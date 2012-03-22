require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


orcKey = 10101
sdkKey = 2281

xlclient = XLAPIClient.new
xlclient.defaultLogin

fiIntf = xlclient.getUtility('fi')
rs = fiIntf.getProcessFormChildData(sdkKey, orcKey)

xlclient.printRS(rs)

xlclient.close
System.exit 0
