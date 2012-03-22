require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
 
 
usrKey = 62
grpKey = 61
 
xlclient = XLAPIClient.new
xlclient.defaultLogin
 
grpIntf = xlclient.getUtility('grp')
 
t1 = System.currentTimeMillis
grpIntf.addMemberUser(grpKey, usrKey, false)
t2 = System.currentTimeMillis
 
delta = t2-t1
puts "Added user #{usrKey} to role #{grpKey} time = #{delta}"

xlclient.logout
System.exit 0

