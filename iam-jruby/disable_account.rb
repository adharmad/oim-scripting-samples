require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

usrLogin = ARGV[0]
oiuKey = ARGV[1].to_i

jndi = Hashtable.new({
    'java.naming.provider.url' => 't3://host:port/oim',
    'java.naming.factory.initial' => 'weblogic.jndi.WLInitialContextFactory'
})

xlclient = XLAPIClient.new
xlclient.defaultLogin
#xlclient.passwordLoginWithDiscovery('xelsysadm', 'password', jndi)

usrIntf = xlclient.getIntf('usr')

usrKey = xlclient.getUsrKey(usrLogin)


t1 = System.currentTimeMillis
oiuKey = usrIntf.disableAppForUser(usrKey, oiuKey)
t2 = System.currentTimeMillis

delta = t2-t1
puts "Disabled account for user with key = #{usrKey} resource oiu_key = #{oiuKey} time = #{delta}"

xlclient.logout
System.exit 0
