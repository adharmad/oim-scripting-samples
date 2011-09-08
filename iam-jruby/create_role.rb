require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'

include_class 'oracle.iam.identity.rolemgmt.vo.Role'


rolePref = ARGV[0]
 
xlclient = XLAPIClient.new
xlclient.defaultLogin
 
roleMgr = xlclient.getUtility('rolemgr')

roleMap = HashMap.new({
    'Role Name' => rolePref,
    'Role Email' => rolePref + '@oracle.com',
    'Role Description' => rolePref + ' some random string here'
    #'LDAP GUID' => rolePref
})
 

r = Role.new(roleMap)

t1 = System.currentTimeMillis
res = roleMgr.create(r)
roleKey = res.getEntityId()
t2 = System.currentTimeMillis
 
delta = t2-t1
puts "Created role with key = #{roleKey} time = #{delta}"

xlclient.logout 
System.exit 0
