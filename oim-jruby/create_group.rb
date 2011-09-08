require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


grpName = 'Baban'

xlclient = XLAPIClient.new
xlclient.defaultLogin

grpIntf = xlclient.getUtility('grp')

grpHash = {
  'Groups.Group Name' => grpName
}

grpMap = HashMap.new(grpHash)

t1 = System.currentTimeMillis
grpKey = grpIntf.createGroup(grpMap)
t2 = System.currentTimeMillis

delta = t2-t1
puts "Created grp with key = #{grpKey} time = #{delta}"

xlclient.close
System.exit 0
