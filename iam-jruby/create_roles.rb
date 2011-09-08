require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
 
include_class 'oracle.iam.identity.rolemgmt.vo.Role'
 
prefix = 'testrole'
count = 10
 
xlclient = XLAPIClient.new
xlclient.defaultLogin
 
roleMgr = xlclient.getUtility('rolemgr')

for i in (1..count)
    roleName = prefix + i.to_s

    roleMap = HashMap.new({
        'Role Name' => roleName,
        'Role Email' => roleName + '@example.com',
        'Role Description' => roleName + ' description'
    })

    r = Role.new(roleMap)

    t1 = System.currentTimeMillis
    res = roleMgr.create(r)
    roleKey = res.getEntityId()
    t2 = System.currentTimeMillis
    
    delta = t2-t1
    puts "Created role with key = #{roleKey} time = #{delta}"
end
 
xlclient.logout 
System.exit 0
