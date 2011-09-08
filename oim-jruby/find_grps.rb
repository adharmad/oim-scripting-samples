require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


xlclient = XLAPIClient.new
xlclient.defaultLogin


grpIntf = xlclient.getUtility('grp')
rs = grpIntf.findGroups(HashMap.new({}))

xlclient.printRS(rs)
xlclient.close
System.exit 0
