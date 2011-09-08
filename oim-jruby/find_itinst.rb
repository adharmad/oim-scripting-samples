require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class('java.lang.String') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


xlclient = XLAPIClient.new
xlclient.defaultLogin

itinst = xlclient.getUtility('itinst')

sc = HashMap.new

rs = itinst.findITResourceInstances(sc)
xlclient.printRS(rs)

xlclient.close
System.exit 0
