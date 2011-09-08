(use '[clojure.contrib.str-utils :only (str-join)])
(import '(java.util HashMap Iterator Properties)
        '(Thor.API tcUtilityFactory)
        '(Thor.API.Operations tcUserOperationsIntf tcFormDefinitionOperationsIntf tcFormInstanceOperationsIntf tcGroupOperationsIntf tcOrganizationOperationsIntf tcReconciliationOperationsIntf tcAccessPolicyOperationsIntf)
        '(com.thortech.xl.util.config ConfigurationClient)
        '(com.thortech.xl.crypto tcCryptoUtil tcSignatureMessage))

(load "xelconst")

(defn login
  "Performs login and returns a tcUtilityFactory instance.
  There are three overloaded methods of this signature. The default
  method without any parameters will login using xelsysadm/xelsysadm.
  The method that takes a single parameter will attempt to perform
  signature based login with the userid provided. The method with
  the explicit login and password provided with use them to login"
  ([] (login "xelsysadm" "xelsysadm"))
  ([username] 
    (let [
      jndi (.getAllSettings (ConfigurationClient/getComplexSettingByPath "Discovery.CoreServer")) 
      signedMsg (tcCryptoUtil/sign username "PrivateKey")
    ]
      (tcUtilityFactory. jndi signedMsg)))
  ([username password]
    (let [jndi (.getAllSettings (ConfigurationClient/getComplexSettingByPath "Discovery.CoreServer"))]
      (tcUtilityFactory. jndi username password))))

(defn logout
  "Closes tcUtilityFactory instance passed"
  [factory]
  (do
    (println "Logging out")
    (.close factory)))

(defn dump-rs
  "Dumps OIM Resultset in humanly readable format"
  [rs]
  (let [cols (.getColumnNames rs) numcols (alength (.. rs getColumnNames))]
    (do
      (dotimes [j numcols]
        (if (not (.endsWith (aget cols j) "Row Version"))
          (print (format "%15s\t" (aget cols j)))))
      (println)
      (println (str-join "" (replicate (* 15 numcols) "=")))
      (dotimes [i (.getRowCount rs)]
        (do
          (.goToRow rs i)
          (dotimes [j numcols]
            (if (not (.endsWith (aget cols j) "Row Version"))
              (print (format "%15s\t" (.getStringValue rs (aget cols j))))))
          (println)))
      (println))))

(defn dump-rs-flat
  "Dumps OIM Resultset containing single row"
  [rs]
  (let [
    cols (.getColumnNames rs) 
    numcols (alength (.. rs getColumnNames))
  ]
    (do
      (dotimes [j numcols]
        (if (not (.endsWith (aget cols j) "Row Version"))
          (println (format "%s = %s" (aget cols j) (.getStringValue rs (aget cols j)))))))))

(defn get-user-key
  [factory userid]
  (let [
    usrIntf (.getUtility factory USR_INTF)    
    usrMap (java.util.HashMap. (hash-map "Users.User ID" userid))
    usrCols (into-array ["Users.Key"])
    usrRS (.findUsersFiltered usrIntf usrMap usrCols)
  ]
    (do
      (.goToRow usrRS 0)
      (.getStringValue usrRS "Users.Key"))))


(defn get-org-key
  [factory orgName]
  (let [
    orgIntf (.getUtility factory ORG_INTF)    
    orgMap (java.util.HashMap. (hash-map "Organizations.Organization Name" orgName))
    orgRS (.findOrganizations orgIntf orgMap)
  ]
    (do
      (.goToRow orgRS 0)
      (.getStringValue orgRS "Organizations.Key"))))


(defn get-grp-key
  [factory grpName]
  (let [
    grpIntf (.getUtility factory GRP_INTF)    
    grpMap (java.util.HashMap. (hash-map "Groups.Group Name" grpName))
    grpRS (.findGroups grpIntf grpMap)
  ]
    (do
      (.goToRow grpRS 0)
      (.getStringValue grpRS "Groups.Key"))))

(defn get-obj-key
  [factory objName]
  (let [
    objIntf (.getUtility factory OBJ_INTF)    
    objMap (java.util.HashMap. (hash-map "Objects.Name" objName))
    objRS (.findObjects objIntf objMap)
  ]
    (do
      (.goToRow objRS 0)
      (.getStringValue objRS "Objects.Key"))))
