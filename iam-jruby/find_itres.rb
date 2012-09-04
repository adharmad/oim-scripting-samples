require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'

xlclient = XLAPIClient.new
#xlclient.defaultLogin
xlclient.passwordLogin('xelsysadm', 'password')

itinst = xlclient.getUtility('itinst')

sc = HashMap.new
rs = itinst.findITResourceInstances(sc)

xlclient.printRS(rs)

xlclient.logout
System.exit 0

