# OIM API interface

import java

from java.lang import *
from java.util import *
from oracle.iam.platform import *
import org.springframework.beans.factory.BeanCreationException
from oracle.iam.identity.usermgmt.api import *
from oracle.iam.identity.orgmgmt.api import *
from com.thortech.xl.util.config import *

class XLAPIClient:
    def __init__(self):
        self.intfMap = {
            'usrmgr' : Class.forName('oracle.iam.identity.usermgmt.api.UserManager'),
            'orgmgr' : Class.forName('oracle.iam.identity.orgmgmt.api.OrganizationManager'),
        }
        
        self.platform = None

    def defaultLogin(self):
        self.passwordLogin('xelsysadm', 'Welcome1')

    def passwordLogin(self, userID, password):
        try:
            print "Logging in"
            self.jndi = ConfigurationClient.getComplexSettingByPath('Discovery.CoreServer').getAllSettings()

            print "jndi = $jndi"

            self.platform = OIMClient(self.jndi)
            self.platform.login(userID, password)
        except Exception, ex:
            print "Exception occured ", ex.message
        
    def logout(self):
        print "Logging out"
        self.platform.logout()
        self.factory.close()

    def getUtility(self, which):
        clsName = self.intfMap[which]
        print str(clsName.__name__)
        self.platform.getService(clsName)
