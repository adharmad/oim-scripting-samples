require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


numGrps = 2
prefix = 'test_group'

xlclient = XLAPIClient.new
xlclient.defaultLogin

grpIntf = xlclient.getUtility('grp')

for i in (1..numGrps)
    grpHash = {
        'Groups.Group Name' => prefix + i.to_s
    }

    grpMap = HashMap.new(grpHash)

    t1 = System.currentTimeMillis
    grpKey = grpIntf.createGroup(grpMap)
	t2 = System.currentTimeMillis

    delta = t2-t1
    puts "Created grp with key = #{grpKey} time = #{delta}"
end

xlclient.close
System.exit 0
