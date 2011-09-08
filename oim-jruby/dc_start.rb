require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class 'java.util.Date'
include_class 'java.util.Calendar'
include_class 'java.util.GregorianCalendar'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

xlclient = XLAPIClient.new
xlclient.defaultLogin

dcIntf = xlclient.getUtility('dc')

sid = ARGV[0]
c = GregorianCalendar.new
#c.set(2010, 5, 1)
c.set(2011, 2, 14, 14, 9, 59)
d = c.getTime

puts d.to_s

entityMap = HashMap.new({
    'User' => nil
    #'Entitlement' => c.getTime
    #'User' => nil,
    #'Entitlement' => nil,
    #'hundred' => nil
    #'OIA1' => nil
})

dcIntf.startDataCollection(sid, entityMap)

puts "Started data collection for session #{sid}"

xlclient.close
System.exit 0
