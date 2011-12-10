import java.util.HashSet

XLClient oimClient = new XLClient('xelsysadm', 'Welcome1')

def roleMgr = oimClient.roleMgr
def grpIntf = oimClient.grpIntf
def usrIntf = oimClient.usrIntf

def roleName = args[0]
def usrName = args[1]

def roleKey = Utils.getGroupKey(grpIntf, roleName).toString()
def usrKey = Utils.getUserKey(usrIntf, usrName).toString()

def usrSet = new HashSet()
usrSet.add(usrKey)

def res = roleMgr.grantRole(roleKey, usrSet)
def id = res.getEntityId()


println "Granted role with name = ${roleName} to user - ${usrName} result = ${id}"

oimClient.close()
System.exit(0)
