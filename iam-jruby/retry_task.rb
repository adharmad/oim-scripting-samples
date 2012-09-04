require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

taskKey = ARGV[0].to_i

xlclient = XLAPIClient.new
xlclient.defaultLogin

provIntf = xlclient.getIntf('prov')

provIntf.retryTask(taskKey)

puts "Retried task with key = #{taskKey}"

xlclient.logout
System.exit 0

