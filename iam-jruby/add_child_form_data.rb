require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

orcKey = 152
sdkKey = 46
formName = 'UD_ANOTCHLD'


xlclient = XLAPIClient.new
xlclient.defaultLogin

fiIntf = xlclient.getUtility('fi')


# first child table entry
udChildMap = HashMap.new({
    formName + '_ENT' => 'YES!!!',
    formName + '_FOO' => 'JUST DO IT'
})

fiIntf.addProcessFormChildData(sdkKey, orcKey, udChildMap)


puts "Updated child form for orc_key = #{orcKey}"

xlclient.logout
System.exit 0

