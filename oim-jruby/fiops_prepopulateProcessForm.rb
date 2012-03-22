require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


orc_key = 10101
sdk_key = 2261

xlclient = XLAPIClient.new
xlclient.defaultLogin

fiIntf = xlclient.getUtility('fi')
rs = fiIntf.prepopulateProcessForm(orc_key, sdk_key, HashMap.new)

xlclient.printRS(rs)

xlclient.close
System.exit 0
