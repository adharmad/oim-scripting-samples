require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashSet'


roleKey = '22'
beginUsrKey = 111
endUsrKey = 210

xlclient = XLAPIClient.new
xlclient.defaultLogin
 
roleMgr = xlclient.getUtility('rolemgr')

userSet = HashSet.new

for i in beginUsrKey..endUsrKey
    userSet.add(i.to_s)
end

res = roleMgr.grantRole(roleKey, userSet)
id = res.getEntityId()
status = res.getStatus()

puts "granted role #{roleKey} to users with keys #{beginUsrKey} - #{endUsrKey}"
    
xlclient.logout 
System.exit 0
