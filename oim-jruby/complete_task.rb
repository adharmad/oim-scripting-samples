require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


orc_key = 1444

xlclient = XLAPIClient.new
xlclient.defaultLogin

provIntf = xlclient.getUtility('prov')

provRS = provIntf.getProcessDetail(orc_key)
#xlclient.printRS(provRS)

t1 = System.currentTimeMillis
# update task
t2 = System.currentTimeMillis
delta = t2-t1
#puts "Updated user with key = #{usr_key} time = #{delta}"

xlclient.close
System.exit 0
