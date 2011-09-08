(load "xelconst")

;; grp struct
(defstruct oim-grp :grp-name)

(defn new-grp
  "Create an group value object"
  [grpname]
  (struct-map oim-grp
    :grp-name grpname))

(defn get-grp-map
  "Converts a oim-grp struct to a java.util.HashMap that can be used
   by tcGroupOperationsIntf->createUser API"
  [oimgrp]
  (java.util.HashMap.
    (reduce 
      (fn [oimgrp [k v]] 
        (assoc oimgrp (.get grp-meta-map k) v)) {} oimgrp)))

(defn create-group
  "Create a Group in OIM with the provided group name."
  [factory grpName]
  (let [
      grpIntf (.getUtility factory GRP_INTF)
      grp-vo (new-grp grpName)
    ]
      (.createGroup grpIntf (get-grp-map grp-vo))))

(defn create-groups
  "Create a grps in OIM with the provided prefix"
  [factory prefix num]
  (dotimes [i num]
    (let [grpIntf (.getUtility factory GRP_INTF) 
      grpName (str prefix i)
      grp-vo (new-grp grpName)
    ]
      (do
        (def grpkey (.createGroup grpIntf (get-grp-map grp-vo)))
        (println (format "Created group with name %s and key %d" grpName grpkey))))))
