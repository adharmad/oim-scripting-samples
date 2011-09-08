require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

polName = 'hellopolicy'
groupName = 'hello_grp'
objName = 'hello_res'

xlclient = XLAPIClient.new
xlclient.defaultLogin

apIntf = xlclient.getUtility('ap')


polHash = {
    'Access Policies.Retrofit Flag' => '1',
	'Access Policies.By Request' =>  '0',
	'Access Policies.Description' =>  'test',
	'Access Policies.Name' =>  polName,
	'Access Policies.Note' =>  polName + '_note'
}

polMap = HashMap.new(polHash)

provObjKeys = [xlclient.getObjKey(objName)].to_java(:long)
revokeObjectsIfNotApply = [false].to_java(:boolean)
denyObjKeys = [].to_java(:long)
groupKeys = [xlclient.getGrpKey(groupName)].to_java(:long)


t1 = System.currentTimeMillis
apKey = apIntf.createAccessPolicy(polHash, provObjKeys, revokeObjectsIfNotApply, denyObjKeys, groupKeys)
t2 = System.currentTimeMillis

delta = t2-t1
puts "Created policy with key = #{apKey} time = #{delta}"

xlclient.close
System.exit 0
