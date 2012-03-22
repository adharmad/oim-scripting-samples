require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
include_class 'java.util.HashSet'
include_class 'java.util.ArrayList'

xlclient = XLAPIClient.new
#xlclient.defaultLogin

reqSvc = xlclient.getUtilityUnauth('unauthselfsvc')
 
t1 = System.currentTimeMillis




t2 = System.currentTimeMillis
 
delta = t2-t1

xlclient.logout
System.exit 0
