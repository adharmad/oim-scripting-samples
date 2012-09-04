require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
 
jndi = Hashtable.new({
    'java.naming.provider.url' => 't3://host:port/oim',
    'java.naming.factory.initial' => 'weblogic.jndi.WLInitialContextFactory'
})

xlclient = XLAPIClient.new
#xlclient.defaultLogin
#xlclient.passwordLogin('test1', 'password')
xlclient.passwordLoginWithDiscovery('xelsysadm', 'password', jndi)
 
xlclient = XLAPIClient.new
xlclient.defaultLogin
 
provIntf = xlclient.getIntf('prov')

provRS = provIntf.getAssignedOpenProvisioningTasksPaged(1, HashMap.new, [].to_java(:String), 1, 100, [].to_java(:String), false, false)

xlclient.printRS(provRS)

xlclient.logout
System.exit 0

