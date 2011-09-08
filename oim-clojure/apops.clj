(import '(com.thortech.xl.vo.AccessPolicyResourceData))

(load "xelconst")

(defstruct policy-info
  :policy-name 
  :retrofit-flag 
  :via-request 
  :policy-description 
  :policy-note)

(defstruct access-policy
  :policy-info
  :prov-objects
  :revoke-flags
  :deny-objects
  :groups
  :aprd)

(defn obj-name-to-keys
  "Transform a list of object names to a list of object keys"
  [factory obj-name-lst]
  (map (fn [obj-name] (parse-long (get-obj-key factory obj-name))) obj-name-lst))

(defn grp-name-to-keys
  "Transform a list of group names to a list of group keys"
  [factory grp-name-lst]
  (map (fn [grp-name] (parse-long (get-grp-key factory grp-name))) grp-name-lst))

(defn get-ap-map 
  "Converts a policy-info struct to a java.util.HashMap that can be used
   by tcAccessPolicyOperationsIntf->createAccessPolicy API"
  [apvo]
  (java.util.HashMap.
    (reduce 
      (fn [apvo [k v]] 
        (assoc apvo (.get ap-meta-map k) v)) {} apvo)))

(defn get-long-array
  [coll]
  (if (> (count coll) 0)
    (long-array coll)
    (long-array 0)))

(defn make-access-policy 
  [factory policy-name retrofit-flag via-request policy-description policy-note prov-objects revoke-flags deny-objects groups]
  (struct-map access-policy
    :policy-info 
      (struct-map policy-info
        :policy-name policy-name
        :retrofit-flag retrofit-flag 
        :via-request via-request 
        :policy-description policy-description 
        :policy-note policy-note)
      :prov-objects (get-long-array (obj-name-to-keys factory prov-objects))
      :revoke-flags (clojurehelper.BooleanUtils/boolean_array (java.util.Vector. revoke-flags))
      :deny-objects (get-long-array (obj-name-to-keys factory deny-objects))
      :groups (get-long-array (grp-name-to-keys factory groups))
      :aprd (make-array com.thortech.xl.vo.AccessPolicyResourceData 0)))

(defn create-access-policy
  "Create an access policy using tcAccessPolicyOperationsIntf"
  [factory ap]
  (let [apmap (get-ap-map apvo)
    apIntf (.getUtility factory AP_INTF)]
    (do
      (def apKey (.createAccessPolicy apIntf 
        (get-ap-map (ap :policy-info)) 
        (ap :prov-objects) 
        (ap :revoke-flags) 
        (ap :deny-objects) 
        (ap :groups) 
        (ap :aprd)))
      (println (format 
        "Created access policy with name %s and key %d" 
        (get apvo :policy-name) 
        apKey)))))
