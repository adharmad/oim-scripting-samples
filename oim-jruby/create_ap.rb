require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}
include_class('com.thortech.xl.vo.AccessPolicyResourceData')

prefix = 'AAAA'
polName = prefix + '_pol7'
groupName = prefix + '_grp7'
objName = prefix
itResDefName = prefix
itResName = prefix + '_itres7'
formName = 'UD_' + prefix

xlclient = XLAPIClient.new
xlclient.defaultLogin

apIntf = xlclient.getUtility('ap')
grpIntf = xlclient.getUtility('grp')
itInstIntf = xlclient.getUtility('itinst')
itDefIntf = xlclient.getUtility('itdef')
fdIntf = xlclient.getUtility('itdef')

# get form key
formKey = xlclient.getFormKey(formName)
puts "form name = #{formName} form key = #{formKey}"

# get object key
objKey = xlclient.getObjKey(objName)
puts "obj name = #{objName} obj key = #{objKey}"

# create the group
grpMap = HashMap.new({
    'Groups.Group Name' => groupName
})
grpKey = grpIntf.createGroup(grpMap)
puts "grp name = #{groupName} grp key = #{grpKey}"

# create the itres
itDefKey = xlclient.getITResDefKey(itResDefName)
itresMap = HashMap.new({
    'IT Resources Type Definition.Key' => itDefKey.to_s,
    'IT Resources.Name' => itResName,
    'p' => 'ppp' + '_' + prefix + '_',
    'q' => 'qqq' + '_' + prefix + '_',
    'r' => 'rrr' + '_' + prefix + '_'
})
itresKey = itInstIntf.createITResourceInstance(itresMap)
puts "itres name = #{itResName} itres key = #{itresKey}"

# now create the policy
polMap = HashMap.new({
    'Access Policies.Retrofit Flag' => '1',
	'Access Policies.By Request' =>  '0',
	'Access Policies.Description' =>  'test',
	'Access Policies.Name' =>  polName,
	'Access Policies.Note' =>  polName + '_note'
})

provObjKeys = [objKey].to_java(:long)
revokeObjectsIfNotApply = [false].to_java(:boolean)
denyObjKeys = [].to_java(:long)
groupKeys = [grpKey].to_java(:long)
aprd = AccessPolicyResourceData.new(objKey, objName, formKey, formName, 'P')
aprd.setFormData(HashMap.new({
    formName + '_SERVER' => itresKey.to_s
}))

aprdArray = [aprd].to_java(AccessPolicyResourceData)

apKey = apIntf.createAccessPolicy(polMap, provObjKeys, revokeObjectsIfNotApply, denyObjKeys, groupKeys, aprdArray)

puts "Created policy with key = #{apKey}"

xlclient.close
System.exit 0
