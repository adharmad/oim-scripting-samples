require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


objName = ARGV[0]

xlclient = XLAPIClient.new
xlclient.defaultLogin

objIntf = xlclient.getUtility('obj')
objKey = xlclient.getObjKey(objName)

rs = objIntf.getAssociatedUsers(objKey, HashMap.new)

xlclient.printRS(rs)

xlclient.close
System.exit 0
