require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


usrLogin = 'Q11'
resName = 'res3'
mvaName = 'ch2'

xlclient = XLAPIClient.new
xlclient.defaultLogin

reconIntf = xlclient.getUtility('recon')

reconHash = {
    'f1' => usrLogin,
    'f2' => 'rocket'
}

reconMap = HashMap.new(reconHash)

t1 = System.currentTimeMillis
rceKey = reconIntf.createReconciliationEvent(resName, reconMap, false)
#reconIntf.providingAllMultiAttributeData(rceKey, mvaName, true)

for i in (2..5) 
    childHash = {
        'cc1' => 'abc' + i.to_s,
        'cc2' => 'timepass' + i.to_s
    }
    childMap = HashMap.new(childHash)
    reconIntf.addDirectMultiAttributeData(rceKey, mvaName, childMap)
end

reconIntf.finishReconciliationEvent(rceKey)

t2 = System.currentTimeMillis
delta = t2-t1

puts "Created recon event with key = #{rceKey} time = #{delta}"

xlclient.close
System.exit 0
