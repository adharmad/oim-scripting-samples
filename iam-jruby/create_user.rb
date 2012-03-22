require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
 
 
login = ARGV[0]

jndi = Hashtable.new({
    'java.naming.provider.url' => 't3://adc2101221.us.oracle.com:7001/oim',
    'java.naming.factory.initial' => 'weblogic.jndi.WLInitialContextFactory'
})

xlclient = XLAPIClient.new
xlclient.defaultLogin
#xlclient.passwordLogin('xelsysadm', 'Welcome1')
#xlclient.passwordLoginWithDiscovery('xelsysadm', 'Welcome1', jndi)

usrIntf = xlclient.getIntf('usr')
 
usrHash = {
    'Users.User ID' => login ,
    'Users.First Name' => login + 'First' ,
    'Users.Last Name' => login + 'Last' ,
    'Users.Middle Name' => login + 'Middle' ,
    'Users.Password' => 'Welcome1',
    'Users.Role' => 'Full-Time',
    'Users.Xellerate Type' => 'End-User',
    'Organizations.Key' => '1'
}
 
usrMap = HashMap.new(usrHash)
 
t1 = System.currentTimeMillis
usrKey = usrIntf.createUser(usrMap)
t2 = System.currentTimeMillis
 
delta = t2-t1
puts "Created user with key = #{usrKey} time = #{delta}"

xlclient.logout
System.exit 0

