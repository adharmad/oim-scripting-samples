require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'

change = ARGV[0] 
usrKey = '7' 
 

xlclient = XLAPIClient.new
xlclient.defaultLogin
 
usrMgr = xlclient.getUtility('usrmgr')
 
usrHash = {
  'First Name' => 'Laloo' + change.to_s,
  'Middle Name' => 'Prasad' + change.to_s,
  'Last Name' => 'Yadav' + change.to_s
}


usrMap = HashMap.new(usrHash)
u = User.new(usrKey, usrMap)

t1 = System.currentTimeMillis
#res = usrMgr.modify(usrKey, usrMap, false)
res = usrMgr.modify(u)
usrKey = res.getEntityId()
t2 = System.currentTimeMillis
 
delta = t2-t1
puts "Modified user with key = #{usrKey} time = #{delta}"

xlclient.logout
System.exit 0
