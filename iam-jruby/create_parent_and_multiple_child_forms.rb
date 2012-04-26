require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

parentFormName = 'XX'
childFormNames = ['YY1', 'YY2', 'YY3']
fieldPrefix = 'FF'

xlclient = XLAPIClient.new
xlclient.defaultLogin

fdIntf = xlclient.getUtility('fd')

# create parent form
formMap = HashMap.new({
    'Structure Utility.Table Name' => parentFormName,
    'Structure Utility.Description' => parentFormName + '_description',
    'Structure Utility.Form Description' => parentFormName + '_description',
    'Structure Utility.Latest Version' => '0',
    'Structure Utility.Active Version' => '0',
    'Structure Utility.Form Type' => 'P'
})

fdIntf.createForm(formMap)
puts "Created form with name = #{parentFormName}"

# find the form
formMap = HashMap.new({
    'Structure Utility.Table Name' => 'UD_' + parentFormName
})

rs = fdIntf.findForms(formMap)
rs.goToRow(0)

psdkKey = rs.getLongValue('Structure Utility.Key')
psdkActiveVersion = rs.getLongValue('Structure Utility.Active Version')

# add fields to parent form
fdIntf.createNewVersion(psdkKey, psdkActiveVersion, 'version1')
psdkNewVersion = psdkActiveVersion + 1


# add form fields
for i in (1..5)
    fieldName =  fieldPrefix + i.to_s
    sdcKey = fdIntf.addFormField(psdkKey, psdkNewVersion, fieldName, 'TextField', 'String', 50, i, '', '0', false)
    puts "Added field with key #{sdcKey} to form"
end

# do not activate parent yet

for childFormName in childFormNames
    # create child form 
    formMap = HashMap.new({
        'Structure Utility.Table Name' => childFormName,
        'Structure Utility.Description' => childFormName + '_description',
        'Structure Utility.Form Description' => childFormName + '_description',
        'Structure Utility.Latest Version' => '0',
        'Structure Utility.Active Version' => '0',
        'Structure Utility.Form Type' => 'P'
    })

    fdIntf.createForm(formMap)
    puts "Created form with name = #{childFormName}"

    # find the form
    formMap = HashMap.new({
        'Structure Utility.Table Name' => 'UD_' + childFormName
    })

    rs = fdIntf.findForms(formMap)
    rs.goToRow(0)


    csdkKey = rs.getLongValue('Structure Utility.Key')
    csdkActiveVersion = rs.getLongValue('Structure Utility.Active Version')


    # add fields to the child form
    fdIntf.createNewVersion(csdkKey, csdkActiveVersion, 'version1')
    csdkNewVersion = csdkActiveVersion + 1


    # add form fields
    for i in (1..5)
        fieldName =  fieldPrefix + i.to_s
        sdcKey = fdIntf.addFormField(csdkKey, csdkNewVersion, fieldName, 'TextField', 'String', 50, i, '', '0', false)
        puts "Added field with key #{sdcKey} to form"
    end

    # activate child form
    fdIntf.activateFormVersion(csdkKey, csdkNewVersion)
    puts "Activated form with key #{csdkKey}"


    # attach parent to child form
    fdIntf.attachChildFormToParentForm(psdkKey, psdkNewVersion, csdkKey, csdkNewVersion)
    puts "Attached parent and child form"

end

# activate parent form
fdIntf.activateFormVersion(psdkKey, psdkNewVersion)
puts "Activated form with key #{psdkKey}"


xlclient.logout
System.exit 0
