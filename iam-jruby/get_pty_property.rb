require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

sid = ARGV[0]

jndi = Hashtable.new({
    'java.naming.provider.url' => 't3://adc6160429.us.oracle.com:7001/oim',
    'java.naming.factory.initial' => 'weblogic.jndi.WLInitialContextFactory'
})

xlclient = XLAPIClient.new
#xlclient.defaultLogin
xlclient.passwordLoginWithDiscovery('xelsysadm', 'Welcome1', jndi)

propIntf = xlclient.getIntf('prop')
propVal = propIntf.getPropertyValue('XL.DataCollectionSessionID')

puts "Property value = #{propVal}"

xlclient.logout
System.exit 0

