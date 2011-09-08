(defn create-org
  "Create a Organization in OIM with the provided orgname.
  Parent name is optional"
  ([oimclient orgName]
    (let [
      orgMgr (.getService oimclient oracle.iam.identity.orgmgmt.api.OrganizationManager)
      org (oracle.iam.identity.orgmgmt.vo.Organization.)
    ]
      (do
        (doto org
          (.setAttribute "Organization Name" orgName)
          (.setAttribute "Organization Customer Type" "Company")
          (.setAttribute "Organization Status" "Active"))
        (def orgKey (.createOrganization orgMgr org false))
        (println (format "Created org with name %s and key %s" orgName orgKey)))))

  ([factory orgName parentName]
    (println "Not implemented")))

