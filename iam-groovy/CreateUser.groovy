import oracle.iam.identity.usermgmt.vo.User
import oracle.iam.identity.usermgmt.vo.UserManagerResult

XLClient oimClient = new XLClient('xelsysadm', 'Welcome1')

def login = args[0]
def usrMgr = oimClient.usrMgr

def usrMap = [
    'User Login' : login ,
    'First Name' : login + 'First',
    'Middle Name' : login + 'Middle' ,
    'Last Name' : login + 'Last' ,
    'usr_password' : 'Welcome1',
    'Role' : 'Full-Time',
    'Xellerate Type' : 'End-User',
    'act_key' : new Long(1),
    'Common Name' : login,
    'Email' : login + '@oracle.com'
]


User u = new User(login, new HashMap(usrMap))
def res = usrMgr.create(u)
def usrKey = res.getEntityId()

println "User created login = ${login} key = ${usrKey}"

oimClient.close()
System.exit(0)
