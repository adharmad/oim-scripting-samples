require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}
include_class('com.thortech.xl.vo.AccessPolicyResourceData')

polName = 'tryap1'

xlclient = XLAPIClient.new
xlclient.defaultLogin

apIntf = xlclient.getUtility('ap')
apMap = HashMap.new({
    'Access Policies.Name' => polName
})

apRS = apIntf.findAccessPolicies(apMap)
apRS.goToRow(0)
polKey = apRS.getLongValue('Access Policies.Key')

puts "pol name = #{polName} pol key = #{polKey}"

aprdArr = apIntf.getDataSpecifiedForObjects(polKey)
aprd = aprdArr[0]

objKey = aprd.getObjectKey()
objName = aprd.getObjectName()
sdkKey = aprd.getFormDefinitionKey()
sdkName = aprd.getFormName()
sdkType = aprd.getFormType()
parentMap = aprd.getFormData()
childTables = aprd.getChildTables()


puts "obj key = #{objKey}"
puts "obj name = #{objName}"
puts "form name = #{sdkName}"
puts "form definition key = #{sdkKey}"
puts "form type = #{sdkType}"

parentMap.each do |k,v|
    puts "#{k} ==> #{v}"
end

childTables.each do |k,v|
    puts "#{k} ==> #{v}"

    pctrArray = aprd.getChildTableRecords(k)
    pctrArray.length.times do |i|
        pctr = pctrArray[i]
        action = pctr.getAction()
        recordNum = pctr.getRecordNumber()
        recData = pctr.getRecordData()

        puts "\taction = #{action}"
        puts "\trecord num = #{recordNum}"

        recData.each do |k1,v1|
            puts "\t\t#{k1} ==> #{v1}"
        end
    end
end

# add a child table entry
aprdx = AccessPolicyResourceData.new(objKey, objName, sdkKey, sdkName, sdkType)
aprdx.setFormData(aprd.getFormData())
aprdx.addChildTableRecord(sdkKey, sdkName, 'Add', 
    HashMap.new({

    })

apIntf.setDataSpecifiedForObject(polKey, objKey, sdkKey, aprdx)

xlclient.close
System.exit 0
