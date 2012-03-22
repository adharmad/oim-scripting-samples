require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashSet'


roleKey = '22'
userKey = '212'


xlclient = XLAPIClient.new
xlclient.defaultLogin
 
roleMgr = xlclient.getUtility('rolemgr')

userSet = HashSet.new
userSet.add(userKey)


t1 = System.currentTimeMillis
res = roleMgr.grantRole(roleKey, userSet)
id = res.getEntityId()
status = res.getStatus()
t2 = System.currentTimeMillis
 
delta = t2-t1
puts "Role grant API invoked id = #{id} status = #{status}"

xlclient.logout 
System.exit 0
