require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'

itinst_key = 2

xlclient = XLAPIClient.new
#xlclient.defaultLogin
xlclient.passwordLogin('adharmad', 'Password1')

itinst = xlclient.getUtility('itinst')

sc = HashMap.new
rs = itinst.getITResourceInstanceParameters(itinst_key)

xlclient.printRS(rs)

xlclient.logout
System.exit 0

