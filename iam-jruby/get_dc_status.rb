require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

sid = ARGV[0]

xlclient = XLAPIClient.new
xlclient.defaultLogin

dcIntf = xlclient.getIntf('dc')

status = dcIntf.getDataCollectionStatus(sid)
        
puts "sid = #{sid} status = #{status}"

xlclient.logout
System.exit 0

