require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

numITRes = 3
prefix = 'mytest'
itDefName = 'Dummy IT Resource Definition'

xlclient = XLAPIClient.new
xlclient.defaultLogin

itInstIntf = xlclient.getUtility('itinst')
itDefIntf = xlclient.getUtility('itdef')

itDefKey = xlclient.getITResDefKey(itDefName)

for i in (1..numITRes)
    itresData = {
        'IT Resources Type Definition.Key' => itDefKey.to_s,
        'IT Resources.Name' => prefix + '_' + i.to_s,
        'server' => 'serverip' + '_' + prefix + '_' + i.to_s,
        'port' => '8888'
    }

    itresMap = HashMap.new(itresData)

    t1 = System.currentTimeMillis
    itresKey = itInstIntf.createITResourceInstance(itresMap)
	t2 = System.currentTimeMillis

    delta = t2-t1
    puts "Created itresourcee with key = #{itresKey} time = #{delta}"
end

xlclient.close
System.exit 0
