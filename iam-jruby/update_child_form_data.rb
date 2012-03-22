
require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

sdkKey = 46
udTableKey = 21
formName = 'UD_ANOTCHLD'


xlclient = XLAPIClient.new
xlclient.defaultLogin

fiIntf = xlclient.getUtility('fi')


# first child table entry
udChildMap = HashMap.new({
    formName + '_ENT' => 'TEST!!! 3',
    formName + '_FOO' => 'UPDATED!! 4'
})

fiIntf.updateProcessFormChildData(sdkKey, udTableKey, udChildMap)


puts "Updated child form"

xlclient.logout
System.exit 0

