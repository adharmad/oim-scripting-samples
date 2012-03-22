require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

numITRes = 5
prefix = 'r2_itres'
itDefName = 'R2Type'

jndi = Hashtable.new({
    'java.naming.provider.url' => 't3://dadvmn0540.us.oracle.com:7003/oim',
    'java.naming.factory.initial' => 'weblogic.jndi.WLInitialContextFactory'
})

xlclient = XLAPIClient.new
xlclient.defaultLogin
#xlclient.passwordLogin('xelsysadm', 'Welcome1')
#xlclient.passwordLoginWithDiscovery('xelsysadm', 'Welcome1', jndi)

itInstIntf = xlclient.getUtility('itinst')
itDefIntf = xlclient.getUtility('itdef')

itDefKey = xlclient.getITResDefKey(itDefName)

for i in (1..numITRes)
    itresData = {
        'IT Resources Type Definition.Key' => itDefKey.to_s,
        'IT Resources.Name' => prefix + '_' + i.to_s,
        'a' => 'aaa' + '_' + prefix + '_' + i.to_s,
        'b' => 'bbb' + '_' + prefix + '_' + i.to_s
        #'pp' => 'ppp' + '_' + prefix + '_' + i.to_s,
        #'qq' => 'qqq' + '_' + prefix + '_' + i.to_s,
        #'rr' => 'rrr' + '_' + prefix + '_' + i.to_s
    }

    itresMap = HashMap.new(itresData)

    t1 = System.currentTimeMillis
    itresKey = itInstIntf.createITResourceInstance(itresMap)
    t2 = System.currentTimeMillis

    delta = t2-t1
    puts "Created itresourcee with key = #{itresKey} time = #{delta}"
end

xlclient.logout
System.exit 0
