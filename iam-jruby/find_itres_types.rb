require 'java'
require 'xlclient'
 
include_class 'java.lang.System'
include_class 'java.util.HashMap'

xlclient = XLAPIClient.new
xlclient.defaultLogin

itinst = xlclient.getUtility('itdef')

sc = HashMap.new
rs = itinst.getITResourceDefinition(sc)

xlclient.printRS(rs)


xlclient.logout
System.exit 0

