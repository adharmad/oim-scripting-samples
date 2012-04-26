require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


jndi = Hashtable.new({
    'java.naming.provider.url' => 't3://slc01fse.us.oracle.com:8003/oim',
    'java.naming.factory.initial' => 'weblogic.jndi.WLInitialContextFactory'
})

orcKey = 23

xlclient = XLAPIClient.new
#xlclient.defaultLogin
xlclient.passwordLoginWithDiscovery('xelsysadm', 'Welcome1', jndi)

fiIntf = xlclient.getUtility('fi')
rs = fiIntf.getProcessFormData(orcKey)

xlclient.printRS(rs)

xlclient.logout
System.exit 0
