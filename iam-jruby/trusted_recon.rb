require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.lang.Long'
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'

include_class 'oracle.iam.platform.context.ContextAwareNumber'
include_class 'oracle.iam.platform.context.ContextAwareString'
include_class 'oracle.iam.platform.context.ContextManager'
include_class 'oracle.iam.platform.context.ContextManager'
 
 
objName = 'Xellerate User'
#objName = 'AD User Trusted'
id = 'TST003'
change = '_hadkardi'
#id = ARGV[0]
#change = ARGV[1]
 
jndi = Hashtable.new({
    'java.naming.provider.url' => 't3://adc2111036.us.oracle.com:7003/oim',
    'java.naming.factory.initial' => 'weblogic.jndi.WLInitialContextFactory'
})

xlclient = XLAPIClient.new
xlclient.defaultLogin
#xlclient.passwordLogin('xelsysadm', 'Welcome1')
#xlclient.passwordLoginWithDiscovery('xelsysadm', 'Welcome1', jndi)

jobName = xlclient.getRandomString(6)
jobID = rand(1000)

ContextManager.pushContext(jobID.to_s, ContextManager::ContextTypes::RECON, "Setup")
ContextManager.setValue("JOBHISTORYID", ContextAwareNumber.new(jobID), true)
ContextManager.setValue("JOBNAME", ContextAwareString.new(jobName))

reconIntf = xlclient.getUtility('reconsvc')

reconHash = {
    'login' => id,
    'first' => id + '_Fisrt' + change,
    'middle' => id + '_Middle' + change,
    'last' => id + '_Last' + change,
    #'role' => 'Full-Time',
    #'xltype' => 'End-User',
    #'org' => 'Xellerate Users',
    'test' => id + '_test' + change
    #'usr_manager_key' => 'USERMANAGER',
    #'manager_login' => 'USERMANAGER',
    #'manager' => Long.new(19)
}

reconMap = HashMap.new(reconHash)

rceKey = reconIntf.createReconciliationEvent(objName, reconMap, true)

reconIntf.callingEndOfJobAPI()

puts "Created recon event with key = #{rceKey}" 

xlclient.logout
System.exit 0
