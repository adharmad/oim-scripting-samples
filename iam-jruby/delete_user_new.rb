require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
 
usrKey = '15'
 
xlclient = XLAPIClient.new
#xlclient.defaultLogin
xlclient.passwordLogin('xelsysadm', 'Welcome1')
 
usrMgr = xlclient.getUtility('usrmgr')
 
t1 = System.currentTimeMillis
res = usrMgr.delete(usrKey, false)
t2 = System.currentTimeMillis
 
delta = t2-t1
puts "Deleted user with key = #{usrKey} time = #{delta}"

xlclient.logout 
System.exit 0
