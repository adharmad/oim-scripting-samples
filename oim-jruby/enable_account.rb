require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

usrKey = 111
oiuKey = 118

xlclient = XLAPIClient.new
xlclient.defaultLogin

usrIntf = xlclient.getUtility('usr')

t1 = System.currentTimeMillis
usrIntf.enableAppForUser(usrKey, oiuKey)
t2 = System.currentTimeMillis

delta = t2-t1
puts "Enabled resource for user with key = #{usrKey} time = #{delta}"

xlclient.close
System.exit 0
