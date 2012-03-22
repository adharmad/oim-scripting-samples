require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
 
 
prefix = 'krishna'
count = 1000
 
jndi = Hashtable.new({
    'java.naming.provider.url' => 't3://adc2100904.us.oracle.com:7001/oim',
    'java.naming.factory.initial' => 'weblogic.jndi.WLInitialContextFactory'
})

xlclient = XLAPIClient.new
xlclient.defaultLogin
#xlclient.passwordLogin('xelsysadm', 'Welcome1')
#xlclient.passwordLoginWithDiscovery('xelsysadm', 'Welcome1', jndi)

usrMgr = xlclient.getUtility('usrmgr')

for i in (1..count)
    login = prefix + i.to_s

    usrHash = {
        'User Login' => login ,
        'First Name' => login + '_First',
        'Middle Name' => login + '_Middle' ,
        'Last Name' => login + '_Last' ,
        'usr_password' => 'Welcome1',
        'Role' => 'Full-Time',
        'Xellerate Type' => 'End-User',
        'act_key' => 1,
        'Common Name' => login,
        'Email' => login + '@oracle.com'
    }
    
    usrMap = HashMap.new(usrHash)

    t1 = System.currentTimeMillis
    u = User.new(login, usrMap)
    res = usrMgr.create(u)
    usrKey = res.getEntityId()
    t2 = System.currentTimeMillis
    
    delta = t2-t1
    puts "Created user with key = #{usrKey} time = #{delta}"
end
 
xlclient.logout 
System.exit 0
