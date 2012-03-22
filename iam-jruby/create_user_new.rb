require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
 
 
#login = 'FOO003'
login = ARGV[0]

jndi = Hashtable.new({
    'java.naming.provider.url' => 't3://adc6260084.us.oracle.com:14000/oim',
    'java.naming.factory.initial' => 'weblogic.jndi.WLInitialContextFactory'
})

xlclient = XLAPIClient.new
xlclient.defaultLogin
#xlclient.passwordLogin('test1', 'Welcome1')
#xlclient.passwordLoginWithDiscovery('xelsysadm', 'Welcome1', jndi)
 
usrMgr = xlclient.getUtility('usrmgr')
 
usrHash = {
    'User Login' => login ,
    'First Name' => login + 'First',
    'Middle Name' => login + 'Middle' ,
    'Last Name' => login + 'Last' ,
    'usr_password' => 'Welcome1',
    'Role' => 'Full-Time',
    'Xellerate Type' => 'End-User',
    'act_key' => 1,
    'Common Name' => login,
    'Email' => login + '@oracle.com',
    #'Business Segment' => 'segment1',
    #'Location Code' => 'location1'
    #'test1' => login + '_test',
    #'custom1' => login + '_custom'
}
 
usrMap = HashMap.new(usrHash)
 

t1 = System.currentTimeMillis
u = User.new(login, usrMap)
res = usrMgr.create(u)
usrKey = res.getEntityId()
t2 = System.currentTimeMillis
 
delta = t2-t1
puts "Created user with key = #{usrKey} time = #{delta}"

xlclient.logout 
System.exit 0
