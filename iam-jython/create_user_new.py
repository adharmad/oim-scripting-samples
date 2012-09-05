import java

from xlclient import *
from java.lang import *
from java.util import *

 
login = 'TEST001'
xlclient = XLAPIClient()
xlclient.defaultLogin()
usrMgr = xlclient.getUtility('usrmgr')
 
usrDict = {
    'User Login' : login ,
    'First Name' : 'abcd',
    'Middle Name' : login + 'Middle' ,
    'Last Name' : login + 'Last' ,
    'usr_password' : 'Welcome1',
    'Role' : 'Full-Time',
    'Xellerate Type' : 'End-User',
    'act_key' : 1,
    'Common Name' : login
}
 
t1 = System.currentTimeMillis
res = usrMgr.create(usrDict)
usrKey = res.getEntityId()
t2 = System.currentTimeMillis
 
delta = t2-t1
print "Created user with key = #{usrKey} time = #{delta}"

xlclient.logout()
System.exit(0)
