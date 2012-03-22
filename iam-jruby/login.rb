require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'

xlclient = XLAPIClient.new
xlclient.passwordLogin('test5', 'foo')
 
xlclient.logout 
System.exit 0
