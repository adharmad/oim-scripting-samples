require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

tableName = ARGV[0]
fieldPrefix = 'FIELD'

xlclient = XLAPIClient.new
xlclient.defaultLogin

fdIntf = xlclient.getUtility('fd')

# create form
formMap = HashMap.new({
    'Structure Utility.Table Name' => tableName,
    'Structure Utility.Description' => tableName + '_description',
    'Structure Utility.Form Description' => tableName + '_description',
    'Structure Utility.Latest Version' => '0',
    'Structure Utility.Active Version' => '0',
    'Structure Utility.Form Type' => 'P'
})

fdIntf.createForm(formMap)
puts "Created form with name = #{tableName}"

# find the form
formMap = HashMap.new({
    'Structure Utility.Table Name' => 'UD_' + tableName
})

rs = fdIntf.findForms(formMap)
rs.goToRow(0)
#xlclient.printRS(rs)


sdkKey = rs.getLongValue('Structure Utility.Key')
sdkActiveVersion = rs.getLongValue('Structure Utility.Active Version')

# create new version
fdIntf.createNewVersion(sdkKey, sdkActiveVersion, 'version1')
sdkNewVersion = sdkActiveVersion + 1


# add form fields
for i in (1..30)
    fieldName =  fieldPrefix + i.to_s
    sdcKey = fdIntf.addFormField(sdkKey, sdkNewVersion, fieldName, 'TextField', 'String', 50, i, '', '0', false)
    puts "Added field with key #{sdcKey} to form"
end

fdIntf.activateFormVersion(sdkKey, sdkNewVersion)
puts "Activated form with key #{sdkKey}"

xlclient.logout
System.exit 0
