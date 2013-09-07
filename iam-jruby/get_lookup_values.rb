require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
 
 
login = ARGV[0]

jndi = Hashtable.new({
    'java.naming.provider.url' => 't3://host:port/oim',
    'java.naming.factory.initial' => 'weblogic.jndi.WLInitialContextFactory'
})

xlclient = XLAPIClient.new
xlclient.defaultLogin
#xlclient.passwordLogin('xelsysadm', 'Welcome1')
#xlclient.passwordLoginWithDiscovery('xelsysadm', 'Welcome1', jndi)

lookupIntf = xlclient.getIntf('lookup')
 
t1 = System.currentTimeMillis
rs = lookupIntf.getLookupValues('Lookup.blahchild.ent')
#xlclient.printRS(rs)

for i in 0..(rs.getRowCount-1)
    rs.goToRow(i)
    puts rs.getStringValue('Lookup Definition.Lookup Code Information.Code Key') + ' => ' + rs.getStringValue('Lookup Definition.Lookup Code Information.Decode')
end

t2 = System.currentTimeMillis
 
delta = t2-t1
puts "Got lookup values time=#{delta}"

xlclient.logout
System.exit 0

