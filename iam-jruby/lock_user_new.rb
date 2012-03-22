require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
 
 
usrKey = '7'
 
xlclient = XLAPIClient.new
xlclient.defaultLogin
 
usrMgr = xlclient.getUtility('usrmgr')
 
t1 = System.currentTimeMillis
res = usrMgr.lock(usrKey, true)
t2 = System.currentTimeMillis
 
delta = t2-t1
puts "Lock user with key = #{usrKey} time = #{delta}"

xlclient.logout
System.exit 0
