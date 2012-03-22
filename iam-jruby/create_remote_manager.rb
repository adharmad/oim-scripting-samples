require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

itResName = 'remote_manager1'
itDefName = 'Remote Manager'

xlclient = XLAPIClient.new
xlclient.defaultLogin

itInstIntf = xlclient.getUtility('itinst')
itDefIntf = xlclient.getUtility('itdef')

itDefKey = xlclient.getITResDefKey(itDefName)

itresData = {
    'IT Resources Type Definition.Key' => itDefKey.to_s,
    'IT Resources.Name' => itResName,
    'service name' => 'RManager',
    'url' => 'rmi://localhost:12345'
}

itresMap = HashMap.new(itresData)

t1 = System.currentTimeMillis
itresKey = itInstIntf.createITResourceInstance(itresMap)
t2 = System.currentTimeMillis

delta = t2-t1
puts "Created itresourcee with key = #{itresKey} time = #{delta}"

xlclient.logout
System.exit 0

