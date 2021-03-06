require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.lang.Integer'
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
 
include_class 'oracle.iam.configservice.vo.AttributeDefinition'
include_class 'oracle.iam.configservice.api.Constants'
#include_class 'oracle.iam.configservice.api.Constants.Encryption'
#include_class 'oracle.iam.configservice.api.Constants.Entity'
 
udf = ARGV[0]

jndi = Hashtable.new({
    'java.naming.provider.url' => 't3://adc2101221.us.oracle.com:7001/oim',
    'java.naming.factory.initial' => 'weblogic.jndi.WLInitialContextFactory'
})

xlclient = XLAPIClient.new
xlclient.defaultLogin
#xlclient.passwordLogin('test1', 'Welcome1')
#xlclient.passwordLoginWithDiscovery('xelsysadm', 'Welcome1', jndi)
 
cfgMgr = xlclient.getUtility('cfgmgr')

t1 = System.currentTimeMillis
#cfgMgr.deleteAttribute(Constants::Entity::USER, udf);
cfgMgr.deleteAttribute(1, udf);
t2 = System.currentTimeMillis
 
delta = t2-t1
puts "User defined field #{udf} created  time = #{delta}"

xlclient.logout 
System.exit 0
