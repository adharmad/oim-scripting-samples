require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

#sid = ARGV[0]

jndi = Hashtable.new({
    'java.naming.provider.url' => 't3://adc2101221.us.oracle.com:7001/oim',
    'java.naming.factory.initial' => 'weblogic.jndi.WLInitialContextFactory'
})

xlclient = XLAPIClient.new
#xlclient.defaultLogin
xlclient.passwordLoginWithDiscovery('xelsysadm', 'Welcome1', jndi)

dcIntf = xlclient.getIntf('dc')

sid = dcIntf.getCurrentDataCollectionSession()
        
puts "sid = #{sid}"

xlclient.logout
System.exit 0

