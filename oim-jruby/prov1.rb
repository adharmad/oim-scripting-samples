require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

usrKey = 6875
objKey1 = 2721
#objKey2 = 11

xlclient = XLAPIClient.new
xlclient.defaultLogin

usrIntf = xlclient.getUtility('usr')

t1 = System.currentTimeMillis
usrIntf.provisionObject(usrKey, objKey1)
#usrIntf.provisionObject(usrKey, objKey2)
t2 = System.currentTimeMillis

delta = t2-t1
puts "Provisioned user with key = #{usrKey} time = #{delta}"

xlclient.close
System.exit 0
