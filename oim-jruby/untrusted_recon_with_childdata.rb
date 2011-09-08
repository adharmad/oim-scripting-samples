require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


objName = 'testobj'
id = 'TST1'
change = 'changeit'

xlclient = XLAPIClient.new
xlclient.defaultLogin

reconIntf = xlclient.getUtility('recon')

reconHash = {
    'login' => id
#    'data' => id + change
}

reconMap = HashMap.new(reconHash)

t1 = System.currentTimeMillis
rceKey = reconIntf.createReconciliationEvent(objName, reconMap, false)


#reconIntf.providingAllMultiAttributeData(rceKey, 'dellc1', true)
# first child table entry
childHash = {
    'c1key' => id + '_c1key',
    'c1data' => id + change
}

childMap = HashMap.new(childHash)
reconIntf.addMultiAttributeData(rceKey, 'datac1', childMap)

#reconIntf.providingAllMultiAttributeData(rceKey, 'dellc2', true)
# first child table entry
childHash = {
    'c2key' => id + '_c2key',
    'c2data' => id + change
}

childMap = HashMap.new(childHash)
reconIntf.addMultiAttributeData(rceKey, 'datac2', childMap)


reconIntf.finishReconciliationEvent(rceKey)

puts "Created recon event with key = #{rceKey}" 

xlclient.close
System.exit 0
