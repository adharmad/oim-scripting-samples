require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'

jndi = Hashtable.new({
    'java.naming.provider.url' => 't3://blr2241016.idc.oracle.com:9003/oim',
    'java.naming.factory.initial' => 'weblogic.jndi.WLInitialContextFactory'
})

xlclient = XLAPIClient.new
xlclient.defaultLogin
#xlclient.passwordLogin('test1', 'Welcome1')
#xlclient.passwordLoginWithDiscovery('xelsysadm', 'Welcome1', jndi)

provint = xlclient.getUtility('provint')

rs = provint.invokeLegacyAPI('Thor.API.Operations.tcITResourceInstanceOperationsIntf', 'findITResourceInstances', [HashMap.new])

xlclient.printRS(rs)

xlclient.logout
System.exit 0
