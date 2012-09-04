require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'

include_class 'oracle.iam.platform.context.ContextAwareNumber'
include_class 'oracle.iam.platform.context.ContextAwareString'
include_class 'oracle.iam.platform.context.ContextManager'
include_class 'oracle.iam.provisioning.vo.Account' 
 
id = ARGV[0].to_i
accountKey = ARGV[1].to_i

jndi = Hashtable.new({
    'java.naming.provider.url' => 't3://host:port/oim',
    'java.naming.factory.initial' => 'weblogic.jndi.WLInitialContextFactory'
})

xlclient = XLAPIClient.new
#xlclient.defaultLogin
#xlclient.passwordLogin('xelsysadm', 'password')
xlclient.passwordLoginWithDiscovery('xelsysadm', 'password', jndi)


ContextManager.pushContext("MANUALPROV", ContextManager::ContextTypes::ADMIN, "")
ContextManager.setValue("TASKNUMBER", ContextAwareNumber.new(id), true)

provIntf = xlclient.getUtility('provsvc')

begin
    puts "Invoking API..."
    Account act = provIntf.getAccountDetails(accountKey)
    puts "Got account details...." 
    #status = act.getAccountStatus()
    #accountKey = act.getAccountKey()
    #   puts "#{status} : #{accountKey} : #{accountKey}"


    ContextManager.popContext();
rescue Throwable => t
    puts "some error"
end

#Account act1 = provIntf.getAccountDetails(accountKey)


xlclient.logout
System.exit 0
