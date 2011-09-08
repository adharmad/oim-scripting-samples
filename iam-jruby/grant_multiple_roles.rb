require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashSet'


beginRoleKey = '30'
endRoleKey = '39'
usrKey = 7

xlclient = XLAPIClient.new
xlclient.defaultLogin
 
roleMgr = xlclient.getUtility('rolemgr')

userSet = HashSet.new
userSet.add(usrKey.to_s)

for i in beginRoleKey..endRoleKey
    res = roleMgr.grantRole(i, userSet)
    id = res.getEntityId()
    status = res.getStatus()

    puts "id = #{id} status=#{status}"
end

xlclient.logout 
System.exit 0
