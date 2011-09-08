(load "xelconst")

;; org struct
(defstruct oim-org :org-name :org-type)

(defn new-org 
  "Create an organization value object"
  ([orgname]
    (struct-map oim-org 
      :org-name orgname
      :org-type "Company"))
  ([orgname parent]
    (struct-map oim-org 
      :org-name orgname
      :org-type "Company"
      :org-parent parent)))

(defn get-org-map 
  "Converts a oim-org struct to a java.util.HashMap that can be used
   by tcOrganizationOperationsIntf->createUser API"
  [oimorg]
  (java.util.HashMap.
    (reduce 
      (fn [oimorg [k v]] 
        (assoc oimorg (.get org-meta-map k) v)) {} oimorg)))

(defn create-org
  "Create a Organization in OIM with the provided orgname. 
  Parent name is optional"
  ([factory orgName]
    (let [
      orgIntf (.getUtility factory ORG_INTF)
      org-vo (new-org orgName)
    ]
      (.createOrganization orgIntf (get-org-map org-vo))))
  ([factory orgName parentName]
    (let [
      orgIntf (.getUtility factory ORG_INTF)
      org-vo (new-org orgName (get-org-key factory parentName))
      orgMap (get-org-map org-vo)
    ]
      (.createOrganization orgIntf (java.util.HashMap. orgMap)))))

(defn create-orgs
  "Create a orgs in OIM with the provided prefix"
  [factory prefix num]
  (dotimes [i num]
    (let [orgIntf (.getUtility factory ORG_INTF) 
      orgName (str prefix i)
      org-vo (new-org orgName)
    ]
      (do
        (def actkey (.createOrganization orgIntf (get-org-map org-vo)))
        (println (format "Created org with name %s and key %d" orgName actkey))))))
