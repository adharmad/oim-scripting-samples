require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

tableName = ARGV[0]

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

xlclient.logout
System.exit 0
