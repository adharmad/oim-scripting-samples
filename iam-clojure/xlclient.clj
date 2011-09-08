(use '[clojure.contrib.str-utils :only (str-join)])
(import '(java.util HashMap Iterator Properties)
        '(org.springframework.beans.factory.BeanCreationException)
        '(com.thortech.xl.util.config ConfigurationClient)
        '(oracle.iam.platform.OIMClient)
        '(oracle.iam.identity.usermgmt.api.UserManager)
        '(oracle.iam.identity.orgmgmt.vo.Organization)
        '(oracle.iam.identity.orgmgmt.api.OrganizationManager))

(defn login
  "Performs login and returns a tcUtilityFactory instance.
  There are three overloaded methods of this signature. The default
  method without any parameters will login using xelsysadm/xelsysadm.
  The method that takes a single parameter will attempt to perform
  signature based login with the userid provided. The method with
  the explicit login and password provided with use them to login"
  ([] (login "xelsysadm" "xelsysadm"))
  ([username password]
    (let [
        jndi (.getAllSettings (ConfigurationClient/getComplexSettingByPath "Discovery.CoreServer"))
        oimclient (oracle.iam.platform.OIMClient. jndi)
      ]
      (do 
        (.login oimclient username password)
        oimclient))))

(defn logout
  "Closes tcUtilityFactory instance passed"
  [oimclient]
  (do
    (println "Logging out")
    (.logout oimclient)))
