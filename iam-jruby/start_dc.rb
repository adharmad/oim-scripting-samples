require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.Date'
include_class 'java.util.Calendar'
include_class 'java.util.GregorianCalendar'
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

sid = ARGV[0]

jndi = Hashtable.new({
    'java.naming.provider.url' => 't3://adc2101163.us.oracle.com:14000/oim',
    'java.naming.factory.initial' => 'weblogic.jndi.WLInitialContextFactory'
})

xlclient = XLAPIClient.new
#xlclient.defaultLogin
xlclient.passwordLoginWithDiscovery('xelsysadm', 'password', jndi)

dcIntf = xlclient.getIntf('dc')

c = GregorianCalendar.new
#c.set(2010, 5, 1)
c.set(2010, 8, 1)

dcHash = {
    #'User' => nil
    #'User' => c.getTime
    #'Entitlement' => nil,
    #'SIMRES' => nil,
    #'RoleMembership' => nil
}

dcMap = HashMap.new(dcHash)

dcIntf.startDataCollection(sid, dcMap)
        
puts "Started data collection"

xlclient.logout
System.exit 0

