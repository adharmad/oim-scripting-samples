require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.lang.Thread' 
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


sch_key = 12686

xlclient = XLAPIClient.new
xlclient.defaultLogin

provIntf = xlclient.getUtility('prov')
rs = provIntf.getResponsesForInstanceTask(sch_key)

xlclient.printRS(rs)

xlclient.close
System.exit 0
