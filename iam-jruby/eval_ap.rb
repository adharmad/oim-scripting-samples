require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
 
usrKey = ARGV[0]

jndi = Hashtable.new({
    'java.naming.provider.url' => 't3://psapp5149.central.sun.com:14000/oim',
    'java.naming.factory.initial' => 'weblogic.jndi.WLInitialContextFactory'
})

xlclient = XLAPIClient.new
#xlclient.defaultLogin
#xlclient.passwordLogin('xelsysadm', 'Welcome1')
xlclient.passwordLoginWithDiscovery('xelsysadm', 'Welcome1', jndi)
 
apSvc = xlclient.getUtility('apsvc')

apSvc.evalutePoliciesForUser(usrKey)
 
puts "Evaluated policies for user key = #{usrKey}"

xlclient.logout 
System.exit 0
