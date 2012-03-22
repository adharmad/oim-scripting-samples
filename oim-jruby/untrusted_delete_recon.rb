require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


objName = 'GGGGGG'
id = 'SIDERICA5'

xlclient = XLAPIClient.new
xlclient.defaultLogin

reconIntf = xlclient.getUtility('recon')

reconHash = {
    'id' => id
}

reconMap = HashMap.new(reconHash)

t1 = System.currentTimeMillis
rceKey = reconIntf.createDeleteReconciliationEvent(objName, reconMap)
t2 = System.currentTimeMillis

delta = t2-t1
puts "Created delete recon event with key = #{rceKey} time = #{delta}"

xlclient.close
System.exit 0
