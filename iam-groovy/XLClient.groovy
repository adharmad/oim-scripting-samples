import Thor.API.*
import Thor.API.Operations.*
import com.thortech.xl.util.config.ConfigurationClient
import com.thortech.xl.crypto.tcCryptoUtil
import com.thortech.xl.crypto.tcSignatureMessage

import oracle.iam.platform.OIMClient

import oracle.iam.identity.usermgmt.api.UserManager

class XLClient {

    // constants
    static USR_INTF = "Thor.API.Operations.tcUserOperationsIntf"
    static ORG_INTF = "Thor.API.Operations.tcOrganizationOperationsIntf"
    static GRP_INTF = "Thor.API.Operations.tcGroupOperationsIntf"
    static RECON_INTF = "Thor.API.Operations.tcReconciliationOperationsIntf"
    static OBJ_INTF = "Thor.API.Operations.tcObjectOperationsIntf"
    static PROP_INTF = "Thor.API.Operations.tcPropertyOperationsIntf"
    
    // service interfaces
    def usrMgr

    // api interfaces
    def usrIntf
    def orgIntf
    def grpIntf
    def reconIntf
    def objIntf
    def propIntf
    private factory 
    private oimClient

    XLClient () {
        this("xelsysadm", "Welcome1")
    }

    XLClient (login, password) {
        println "logging into OIM"
        def jndiProps = ConfigurationClient.getComplexSettingByPath(
            "Discovery.CoreServer").getAllSettings()
        factory = new tcUtilityFactory(jndiProps, login, password)
        oimClient = new OIMClient(jndiProps)
        oimClient.login(login, password)
        println "login successful"
        initInterfaces()
    }    

    void initInterfaces() {
        //services
        usrMgr = oimClient.getService(UserManager.class)    

        // interfaces
        usrIntf = factory.getUtility(USR_INTF)
        orgIntf = factory.getUtility(ORG_INTF)
        grpIntf = factory.getUtility(GRP_INTF)
        reconIntf = factory.getUtility(RECON_INTF)
        objIntf = factory.getUtility(OBJ_INTF)
        propIntf = factory.getUtility(PROP_INTF)
    }

    void close() {
        println "logging out"
        factory.close()
    }
}
