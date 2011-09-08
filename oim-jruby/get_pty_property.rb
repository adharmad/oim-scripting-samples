require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

sid = ARGV[0]

xlclient = XLAPIClient.new
xlclient.defaultLogin

propIntf = xlclient.getIntf('prop')
propVal = propIntf.getPropertyValue('XL.DataCollectionSessionID')

puts "Property value = #{propVal}"

xlclient.logout
System.exit 0

