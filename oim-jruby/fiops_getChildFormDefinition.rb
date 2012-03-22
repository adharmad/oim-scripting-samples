require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


sdkKey = 2261
sdkVersion = 1

xlclient = XLAPIClient.new
xlclient.defaultLogin

fiIntf = xlclient.getUtility('fi')
rs = fiIntf.getChildFormDefinition(sdkKey, sdkVersion)

xlclient.printRS(rs)

xlclient.close
System.exit 0

