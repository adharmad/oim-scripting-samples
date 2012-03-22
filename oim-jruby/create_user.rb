require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.lang.Thread' 
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


login = ARGV[0]

xlclient = XLAPIClient.new
#xlclient.defaultLogin
#jndi = Hashtable.new({
#    'java.naming.provider.url' => 'ormi://dadvmn0695.us.oracle.com:23791/Xellerate',
#    'java.naming.factory.initial' => 'oracle.j2ee.rmi.RMIInitialContextFactory'
#})


#xlclient.defaultLogin
xlclient.passwordLogin('bigadmin', 'foo')
#xlclient.signatureLogin('xelsysadm')
#xlclient.remoteLogin('xelsysadm', 'xelsysadm', jndi)

usrIntf = xlclient.getUtility('usr')

usrHash = {
  'Users.User ID' => login ,
  'Users.First Name' => login + '_First' ,
  'Users.Last Name' => login + '_Last' ,
  'Users.Middle Name' => login + '_Middle' ,
  'Users.Password' => 'foo',
  'Users.Role' => 'Full-Time',
  'Users.Xellerate Type' => 'End-User',
  'Organizations.Key' => '1'
  #'USR_UDF_CWFUDF1' => 'hello',
  #'USR_UDF_CWFUDF2' => 'world'
}

usrMap = HashMap.new(usrHash)

t1 = System.currentTimeMillis
usrKey = usrIntf.createUser(usrMap)
t2 = System.currentTimeMillis

delta = t2-t1
puts "Created user with key = #{usrKey} time = #{delta}"

xlclient.close
System.exit 0
