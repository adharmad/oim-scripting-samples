require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


xlclient = XLAPIClient.new
xlclient.defaultLogin
usrIntf = xlclient.getUtility('usr')


usrLogin = 'DDD4'
objName = 'helpdesk'

usrKey = xlclient.getUsrKey(usrLogin)
objKey = xlclient.getObjKey(objName)

puts "usrKey = #{usrKey}"
puts "objKey = #{objKey}"

oiuKey = usrIntf.provisionObject(usrKey, objKey)
puts "oiuKey = #{oiuKey}"

xlclient.close
System.exit 0
