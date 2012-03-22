require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

sdkKey = 46
udTableKey = 20


xlclient = XLAPIClient.new
xlclient.defaultLogin

fiIntf = xlclient.getUtility('fi')

fiIntf.removeProcessFormChildData(sdkKey, udTableKey)

puts "deleted entry from child form for orc_key = #{orcKey}"

xlclient.logout
System.exit 0

