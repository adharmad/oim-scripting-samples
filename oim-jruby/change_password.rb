require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.lang.Thread' 
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

usr_key = 932

xlclient = XLAPIClient.new
xlclient.defaultLogin


passIntf = xlclient.getUtility('pass')

t1 = System.currentTimeMillis
passIntf.setXelleratePassword(usr_key, 'foo1')
t2 = System.currentTimeMillis

delta = t2-t1
puts "Changed password"

xlclient.close
System.exit 0
