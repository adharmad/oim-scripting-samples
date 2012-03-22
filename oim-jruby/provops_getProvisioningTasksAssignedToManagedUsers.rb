require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.lang.Thread' 
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


usr_key = 1

xlclient = XLAPIClient.new
xlclient.defaultLogin

provIntf = xlclient.getUtility('prov')
rs = provIntf.getProvisioningTasksAssignedToManagedUsers(usr_key, HashMap.new, ([].to_java :string))

xlclient.printRS(rs)

xlclient.close
System.exit 0
