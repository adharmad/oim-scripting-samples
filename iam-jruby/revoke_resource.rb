require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

usrKey = 7
oiuKey = 1


xlclient = XLAPIClient.new
xlclient.defaultLogin

usrIntf = xlclient.getIntf('usr')


t1 = System.currentTimeMillis
oiuKey = usrIntf.revokeObject(usrKey, oiuKey)
t2 = System.currentTimeMillis

delta = t2-t1
puts "Revoked user with key = #{usrKey} resource oiu_key = #{oiuKey} time = #{delta}"

xlclient.logout
System.exit 0
