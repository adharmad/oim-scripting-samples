require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

usrKey = 243
objKey = 41


xlclient = XLAPIClient.new
xlclient.defaultLogin

reqIntf = xlclient.getUtility('req')

t1 = System.currentTimeMillis

reqHash = {
    'Requests.Request Priority' => 'High',
    'Requests.Target Type' => 'U',
    'Requests.Object Request Type' => 'Add'
}

reqMap = HashMap.new(reqHash)
reqKey = reqIntf.createRequest(reqMap)
reqIntf.addRequestObject(reqKey, objKey)
		
reqIntf.addRequestUser(reqKey, usrKey)

reqIntf.completeRequestCreation(reqKey)
print 'completed request creation'

t2 = System.currentTimeMillis

delta = t2-t1
puts "Created request with key = #{reqKey} time = #{delta}"

xlclient.close
System.exit 0
