require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


reqKey = 581

xlclient = XLAPIClient.new
xlclient.defaultLogin

reqIntf = xlclient.getUtility('req')

t1 = System.currentTimeMillis
reqIntf.cancelRequest(reqKey)
t2 = System.currentTimeMillis

delta = t2-t1
puts "Cancelled request = #{reqKey} time = #{delta}"

xlclient.close
System.exit 0
