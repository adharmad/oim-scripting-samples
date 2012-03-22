require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
 
 
login = 'HACKER'
 
xlclient = XLAPIClient.new
xlclient.defaultLogin
#xlclient.passwordLogin('xelsysadm', 'welcome1')
 
usrMgr = xlclient.getUtility('usrmgr')
 
usrHash = {
    'User Login' => login ,
    'First Name' => login + 'First' ,
    'Middle Name' => login + 'Middle' ,
    'Last Name' => login + 'Last' ,
    'usr_password' => 'password1',
    'Role' => 'Full-Time',
    'Xellerate Type' => 'End-User',
    'act_key' => 1,
    'Common Name' => login
    #'ENCUDF' => 'hahaha'
}
 
usrMap = HashMap.new(usrHash)
 

t1 = System.currentTimeMillis
res = usrMgr.create(usrMap)
usrKey = res.getEntityId()
t2 = System.currentTimeMillis
 
delta = t2-t1
puts "Created user with key = #{usrKey} time = #{delta}"


for i in (0..10)
    usrHash = {
        'First Name' => 'Laloo' + i.to_s,
        'Middle Name' => 'Prasad' + i.to_s,
        'Last Name' => 'Yadav' + i.to_s
    }
 
    usrMap = HashMap.new(usrHash)

    t1 = System.currentTimeMillis
    res = usrMgr.modify(usrKey, usrMap, false)
    usrKey = res.getEntityId()
    t2 = System.currentTimeMillis
 
    delta = t2-t1
    puts "Modified user with key = #{usrKey} time = #{delta}"
end

xlclient.logout 
System.exit 0
