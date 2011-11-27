import oracle.iam.identity.rolemgmt.vo.Role

XLClient oimClient = new XLClient('xelsysadm', 'Welcome1')

def roleName = args[0]
def roleMgr = oimClient.roleMgr

def roleMap = [
    'Role Name' : roleName, 
    'Role Email' : roleName + '@oracle.com',
    'Role Description' : roleName + ' some random string here'
]

Role r = new Role(roleMap)
def res = roleMgr.create(r)
def roleKey = res.getEntityId()


println "Created role with name = ${roleName} key = ${roleKey}"

oimClient.close()
System.exit(0)
