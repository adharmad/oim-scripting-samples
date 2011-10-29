// add user to group
// Usage:
//  xlclient.cmd AddUserToGroup.groovy <USER_ID> <GROUP_NAME>

def oim = new Oim()
def grpIntf = oim.grpIntf
def usrIntf = oim.usrIntf

def usrLogin = args[0]
def grpName = args[1]

def usrKey = Utils.getUserKey(usrIntf, usrLogin)
def grpKey = Utils.getGroupKey(grpIntf, grpName)

grpIntf.addMemberUser(grpKey, usrKey)

oim.close()
System.exit(0)

