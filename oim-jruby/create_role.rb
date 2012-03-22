require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
 
 
role = 'myrole1'
 
xlclient = XLAPIClient.new
xlclient.defaultLogin
 
grpIntf = xlclient.getUtility('grp')
 
grpHash = {
    'Groups.Group Name' => role
}
 
grpMap = HashMap.new(grpHash)
 
t1 = System.currentTimeMillis
grpKey = grpIntf.createGroup(grpMap)
t2 = System.currentTimeMillis
 
delta = t2-t1
puts "Created role with key = #{grpKey} time = #{delta}"
 
System.exit 0
