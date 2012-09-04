require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

itresName = 'foo1'
itDefName = 'fooType'

jndi = Hashtable.new({
    'java.naming.provider.url' => 't3://adc2201822.us.oracle.com:8003/oim',
    'java.naming.factory.initial' => 'weblogic.jndi.WLInitialContextFactory'
})

xlclient = XLAPIClient.new
xlclient.defaultLogin
#xlclient.passwordLogin('test1', 'password')
#xlclient.passwordLoginWithDiscovery('xelsysadm', 'password', jndi)
 

itInstIntf = xlclient.getUtility('itinst')
itDefIntf = xlclient.getUtility('itdef')

itDefKey = xlclient.getITResDefKey(itDefName)


itresData = {
    'IT Resources Type Definition.Key' => itDefKey.to_s,
    'IT Resources.Name' => itresName,
    'a' => 'aaa' + '_' + itresName,
    'b' => 'bbb' + '_' + itresName
}

itresMap = HashMap.new(itresData)

itresKey = itInstIntf.createITResourceInstance(itresMap)

puts "Created itresourcee with key = #{itresKey}"

xlclient.logout
System.exit 0
