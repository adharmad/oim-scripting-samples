require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


xlclient = XLAPIClient.new
xlclient.defaultLogin
grpIntf = xlclient.getUtility('grp')

    
grpKey = 21
usrKeys = [462].to_java(:long)

puts "usrKey = #{usrKeys}"
puts "grpKey = #{grpKey}"
grpIntf.addMemberUsers(grpKey, usrKeys, false)

xlclient.close
System.exit 0
