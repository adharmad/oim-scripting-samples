require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.Hashtable'
 
grpKey = 29

xlclient = XLAPIClient.new
xlclient.defaultLogin
jndi = Hashtable.new({
    'java.naming.provider.url' => 't3://dadvma0081.us.oracle.com:7001/oim',
    'java.naming.factory.initial' => 'weblogic.jndi.WLInitialContextFactory'
})

#xlclient.passwordLoginWithDiscovery('xelsysadm', 'Welcome1', jndi)

grpIntf = xlclient.getIntf('grp')

rs = grpIntf.getAllMemberUsers(grpKey, 1, 10, "Users.User ID", true)
 
xlclient.printRS(rs)

xlclient.logout
System.exit 0

