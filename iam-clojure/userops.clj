(defn get-user-map [userid]
  (doto (java.util.HashMap.)
    (.put "User Login" userid)
    (.put "First Name" (str userid "_First"))
    (.put "Last Name" (str userid "_Last"))
    (.put "Middle Name" (str userid "_Middle"))
    (.put "Common Name" userid)
    (.put "usr_password" "Welcome1")
    (.put "Xellerate Type" "End-User")
    (.put "Role" "Full-Time")
    (.put "act_key" (Long. "1"))))

(defn create-user
  "Create a user in OIM with the provided userid"
  [oimclient userid]
  (let [usrMgr (.getService oimclient oracle.iam.identity.usermgmt.api.UserManager)]
    (do 
      (def result (.create usrMgr (get-user-map userid)))
      (println (format "Created user with login %s and key %s" userid (.getEntityId result))))))

(defn create-users
  "Create user in OIM with the provided userid"
  [oimclient prefix num]
  (dotimes [i num]
    (let [
        usrMgr (.getService oimclient oracle.iam.identity.usermgmt.api.UserManager)
        userid (str prefix i)
      ]
      (do 
        (def result (.create usrMgr (get-user-map userid)))
        (println (format "Created user with login %s and key %s" userid (.getEntityId result)))))))


(defn get-user-create-proxy
  [oimclient prefix num]
  (proxy [Runnable] []
    (run []
      (let [
        usrMgr (.getService oimclient oracle.iam.identity.usermgmt.api.UserManager)
        tid (.getName (Thread/currentThread))
      ]
        (dotimes [i num]
          (let [userid (str tid "_" prefix "_" i)]
            (do 
              (def result (.create usrMgr (get-user-map userid)))
              (println (format "Created user with login %s and key %s" userid (.getEntityId result))))))))))

(defn mt-create-users
  [oimclient prefix numThreads numPerThread]
  (let [tarr (make-array Thread numThreads)]
    (do
      (dotimes [i numThreads]
        (aset tarr i (Thread. (get-user-create-proxy oimclient prefix numPerThread))))
      (dotimes [i numThreads]
        (.start (aget tarr i)))
      (dotimes [i numThreads]
        (.join (aget tarr i))))))

;
;(defn find-users
;  ([factory]
;    (find-users factory (hash-map)))
;  ([factory sc]
;    (find-users factory sc ["Users.Key" "Users.User ID" "Users.First Name" "Users.Last Name"]))
;  ([factory sc fields]
;    (let [usrIntf (.getUtility factory "Thor.API.Operations.tcUserOperationsIntf")]
;      (.findUsersFiltered usrIntf (java.util.HashMap. sc) (into-array String fields)))))
