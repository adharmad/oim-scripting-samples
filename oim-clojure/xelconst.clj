(def USR_INTF "Thor.API.Operations.tcUserOperationsIntf")
(def ORG_INTF "Thor.API.Operations.tcOrganizationOperationsIntf")
(def GRP_INTF "Thor.API.Operations.tcGroupOperationsIntf")
(def OBJ_INTF "Thor.API.Operations.tcObjectOperationsIntf")
(def AP_INTF "Thor.API.Operations.tcAccessPolicyOperationsIntf")
(def IMP_INTF "Thor.API.Operations.tcImportOperationsIntf")
(def DC_INTF "Thor.API.Operations.DataCollectionOperationsIntf")

;; user metadata map. This will be used to build the real hashmap
;; that is passed to the create-user method
(def user-meta-map 
  (hash-map
    :usr-key "Users.Key" 
    :userid "Users.User ID"
    :first-name "Users.First Name"
    :last-name "Users.Last Name"
    :xltype "Users.Xellerate Type"
    :role "Users.Role"
    :password "Users.Password"
    :org "Organizations.Key"))

;; org metadata map
(def org-meta-map 
  (hash-map 
    :org-key  "Organizations.Key"
    :org-name "Organizations.Organization Name"
    :org-type "Organizations.Type"
    :org-parent "Organizations.Parent Key"))

;; grp metadata map
(def grp-meta-map 
  (hash-map 
    :grp-key "Groups.Key"
    :grp-name "Groups.Group Name"))


;; access policy metadata map
(def ap-meta-map
  (hash-map
    :policy-name "Access Policies.Name"
    :retrofit-flag "Access Policies.Retrofit Flag"
    :via-request "Access Policies.By Request"
    :policy-description "Access Policies.Description"
    :policy-note "Access Policies.Note"))


(defn parse-integer [str]
  (try (Integer/parseInt str) 
       (catch NumberFormatException nfe 0)))

(defn parse-long [str]
  (try (Long/parseLong str) 
       (catch NumberFormatException nfe 0)))
