from java.util import *
from Thor.API import *
from Thor.API.Operations import *
from com.thortech.xl.crypto import *
from com.thortech.xl.util.config import *

class XLAPIClient:
    def __init__(self, userID, password):
        try:
            self.login(userID, password)
            self.initInterfaces()
        except Exception, ex:
            ex.printStackTrace() 

    def login(self, userID, password):
        jndiProps = ConfigurationClient.getComplexSettingByPath(
                'Discovery.CoreServer').getAllSettings()
        print jndiProps
        print 'Logging in'
        if not userID and not password:
            self.factory = tcUtilityFactory(jndiProps, 'xelsysadm',
                'xelsysadm')
        else:
            self.factory = tcUtilityFactory(jndiProps, userID, password)

    def initInterfaces(self):
        self.reqIntf = self.factory.getUtility(
				'Thor.API.Operations.tcRequestOperationsIntf')
        self.usrIntf = self.factory.getUtility(
				'Thor.API.Operations.tcUserOperationsIntf')
        self.orgIntf = self.factory.getUtility(
				'Thor.API.Operations.tcOrganizationOperationsIntf')
        self.grpIntf = self.factory.getUtility(
				'Thor.API.Operations.tcGroupOperationsIntf')        
        self.provIntf = self.factory.getUtility(
				'Thor.API.Operations.tcProvisioningOperationsIntf')
        self.reconIntf = self.factory.getUtility(
				'Thor.API.Operations.tcReconciliationOperationsIntf')
        self.objIntf = self.factory.getUtility(
				'Thor.API.Operations.tcObjectOperationsIntf')
        self.fdIntf = self.factory.getUtility(
				'Thor.API.Operations.tcFormDefinitionOperationsIntf')
        self.fiIntf = self.factory.getUtility(
				'Thor.API.Operations.tcFormInstanceOperationsIntf')
        self.audIntf = self.factory.getUtility(
				'Thor.API.Operations.tcAuditOperationsIntf')
        self.apIntf = self.factory.getUtility(
				'Thor.API.Operations.tcAccessPolicyOperationsIntf')

    def close(self):
        if self.factory:
            print 'Logging out'
            self.factory.close()

    def printRS(self, rs):
        try:
            print 'COUNT = ', str(rs.getRowCount()), '\n\n'
            cols = rs.getColumnNames()

            for i in range(rs.getRowCount()):
                rs.goToRow(i)

                for j in range(len(cols)):
                    if cols[j].find('Row Version') == -1:
                        print cols[j], '\t\t:', rs.getStringValue(cols[j])

                print '\n'
        except Exception, ex:
            ex.printStackTrace()

    def getUsrKey(self, usrLogin):
	    usrMap = HashMap()
	    usrMap.put('Users.User ID', usrLogin)

	    rs = self.usrIntf.findUsersFiltered(usrMap, \
                ['Users.Key', 'Users.User ID'])
	    rs.goToRow(0)
	    return rs.getLongValue('Users.Key')

    def getObjKey(self, objName):
	    objMap = HashMap()
	    objMap.put('Objects.Name', objName)

	    rs = self.objIntf.findObjects(objMap)
	    rs.goToRow(0)
	    return rs.getLongValue('Objects.Key')

    def getGrpKey(self, grpName):
	    grpMap = HashMap()
	    grpMap.put('Groups.Group Name', grpName)

	    rs = self.grpIntf.findGroups(grpMap)
	    rs.goToRow(0)
	    return rs.getLongValue('Groups.Key')
