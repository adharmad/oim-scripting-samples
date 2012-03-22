require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

usrLogin = ARGV[0]
objName = ARGV[1]

jndi = Hashtable.new({
    'java.naming.provider.url' => 't3://w3kdual2srv.us.oracle.com:14000/oim',
    'java.naming.factory.initial' => 'weblogic.jndi.WLInitialContextFactory'
})

xlclient = XLAPIClient.new
xlclient.defaultLogin
#xlclient.passwordLoginWithDiscovery('xelsysadm', 'Welcome1', jndi)

usrIntf = xlclient.getIntf('usr')

usrKey = xlclient.getUsrKey(usrLogin)
objKey = xlclient.getObjKey(objName)


t1 = System.currentTimeMillis
oiuKey = usrIntf.provisionObject(usrKey, objKey)
t2 = System.currentTimeMillis

delta = t2-t1
puts "Provisioned user with key = #{usrKey} resource oiu_key = #{oiuKey} time = #{delta}"

xlclient.logout
System.exit 0

