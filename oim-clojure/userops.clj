(load "xelconst")

;; user struct
(defstruct oim-user :userid :first-name :last-name :xltype :role :password :org)

(defn new-user [userid]
  (struct-map oim-user 
    :userid userid
    :first-name (str userid "_First")
    :last-name (str userid "_Last")
    :xltype "End-User"
    :role "Full-Time"
    :password "foo"
    :org "1"))

(defn get-user-map 
  "Converts a oim-user struct to a java.util.HashMap that can be used
   by tcUserOperationsIntf->createUser API"
  [oimuser]
  (java.util.HashMap.
    (reduce 
      (fn [oimuser [k v]] 
        (assoc oimuser (.get user-meta-map k) v)) {} oimuser)))

(defn create-user
  "Create a user in OIM with the provided userid"
  [factory userid]
  (let [usrIntf (.getUtility factory USR_INTF) 
      user-vo (new-user userid)
    ]
    (.createUser usrIntf (get-user-map user-vo))))

(defn create-users
  "Create a users in OIM with the provided prefix"
  [factory prefix num]
  (dotimes [i num]
    (let [usrIntf (.getUtility factory USR_INTF) 
      userid (str prefix i)
      user-vo (new-user userid)
    ]
      (do
        (def usrkey (.createUser usrIntf (get-user-map user-vo)))
        (println (format "Created user with login %s and key %d" userid usrkey))))))

(defn get-user-create-proxy
  [factory prefix num]
  (proxy [Runnable] []
    (run []
      (let [
        usrIntf (.getUtility factory USR_INTF)
        tid (.getName (Thread/currentThread))
      ]
        (dotimes [i num]
          (let [userid (str tid "_" prefix "_" i) 
            user-vo (new-user userid)
          ]
            (do
              (def usrkey (.createUser usrIntf (get-user-map user-vo)))
              (println (format "Created user with login %s and key %d" userid usrkey)))))))))

(defn mt-create-users
  [factory prefix numThreads numPerThread]
  (let [tarr (make-array Thread numThreads)]
    (do
      (dotimes [i numThreads]
        (aset tarr i (Thread. (get-user-create-proxy factory prefix numPerThread))))
      (dotimes [i numThreads]
        (.start (aget tarr i)))
      (dotimes [i numThreads]
        (.join (aget tarr i))))))

(defn find-users
  ([factory]
    (find-users factory (hash-map)))
  ([factory sc]
    (find-users factory sc ["Users.Key" "Users.User ID" "Users.First Name" "Users.Last Name"]))
  ([factory sc fields]
    (let [usrIntf (.getUtility factory "Thor.API.Operations.tcUserOperationsIntf")]
      (.findUsersFiltered usrIntf (java.util.HashMap. sc) (into-array String fields)))))
