import Thor.API.*
import Thor.API.Operations.*
import com.thortech.xl.util.config.ConfigurationClient
import com.thortech.xl.crypto.tcCryptoUtil
import com.thortech.xl.crypto.tcSignatureMessage


class Oim {

    // constants
    static USR_INTF = "Thor.API.Operations.tcUserOperationsIntf"
    static ORG_INTF = "Thor.API.Operations.tcOrganizationOperationsIntf"
    static GRP_INTF = "Thor.API.Operations.tcGroupOperationsIntf"
    static RECON_INTF = "Thor.API.Operations.tcReconciliationOperationsIntf"
    static REQ_INTF = "Thor.API.Operations.tcRequestOperationsIntf"
    static OBJ_INTF = "Thor.API.Operations.tcObjectOperationsIntf"
    static PROP_INTF = "Thor.API.Operations.tcPropertyOperationsIntf"
    
    // api interfaces
    def usrIntf
    def orgIntf
    def grpIntf
    def reconIntf
    def reqIntf
    def objIntf
    def propIntf
    private factory 

    Oim () {
        this("xelsysadm", "xelsysadm")
    }

    Oim (login) {
        println "logging into OIM"
        def jndiProps = ConfigurationClient.getComplexSettingByPath(
            "Discovery.CoreServer").getAllSettings()
        def signedMsg = tcCryptoUtil.sign(login, "PrivateKey");
		factory = new tcUtilityFactory(jndiProps, signedMsg);

        println "login successful"
        initInterfaces()
    }

    Oim (login, password) {
        println "logging into OIM"
        def jndiProps = ConfigurationClient.getComplexSettingByPath(
            "Discovery.CoreServer").getAllSettings()
        factory = new tcUtilityFactory(jndiProps, login, password)
        println "login successful"
        initInterfaces()
    }    

    void initInterfaces() {
        usrIntf = factory.getUtility(USR_INTF)
        orgIntf = factory.getUtility(ORG_INTF)
        grpIntf = factory.getUtility(GRP_INTF)
        reconIntf = factory.getUtility(RECON_INTF)
        reqIntf = factory.getUtility(REQ_INTF)
        objIntf = factory.getUtility(OBJ_INTF)
        propIntf = factory.getUtility(PROP_INTF)
    }

    void close() {
        println "logging out"
        factory.close()
    }
}
