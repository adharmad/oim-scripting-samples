require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class('java.lang.String') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

obj_key = 2101

xlclient = XLAPIClient.new
xlclient.defaultLogin

objIntf = xlclient.getUtility('obj')

rs = objIntf.getServiceAccountList(obj_key, HashMap.new)
xlclient.printRS(rs)

xlclient.close
System.exit 0

