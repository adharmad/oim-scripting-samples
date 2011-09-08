require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

orcKey = 6123

xlclient = XLAPIClient.new
xlclient.defaultLogin

fiIntf = xlclient.getUtility('fi')

t1 = System.currentTimeMillis

# set process form data
udHash = {
    'UD_EPASS_PASSWORD' => 'foo'
}

udMap = HashMap.new(udHash)
fiIntf.setProcessFormData(orcKey, udMap)

t2 = System.currentTimeMillis

delta = t2-t1
puts "Updated process form for orc_key = #{orcKey} time = #{delta}"

xlclient.close
System.exit 0
