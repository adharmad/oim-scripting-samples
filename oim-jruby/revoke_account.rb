require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

usrKey = 62
#oiuKeys = [59, 60].to_java(:long)
oiuKeys = [72].to_java(:long)

xlclient = XLAPIClient.new
xlclient.defaultLogin

usrIntf = xlclient.getUtility('usr')

t1 = System.currentTimeMillis
usrIntf.revokeObjects(usrKey, oiuKeys)
t2 = System.currentTimeMillis

delta = t2-t1
puts "Revoked resources for user with key = #{usrKey} time = #{delta}"

xlclient.close
System.exit 0
