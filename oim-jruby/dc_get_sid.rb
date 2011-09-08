require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class 'java.util.Date'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

xlclient = XLAPIClient.new
xlclient.defaultLogin

dcIntf = xlclient.getUtility('dc')

sid = dcIntf.getCurrentDataCollectionSession()

puts "current session id = #{sid} "

xlclient.close
System.exit 0
