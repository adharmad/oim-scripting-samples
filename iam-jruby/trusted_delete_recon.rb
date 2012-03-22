require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.Hashtable'
include_class 'java.util.HashMap'

include_class 'oracle.iam.platform.context.ContextAwareNumber'
include_class 'oracle.iam.platform.context.ContextAwareString'
include_class 'oracle.iam.platform.context.ContextManager'
include_class 'oracle.iam.platform.context.ContextManager'
 
 
objName = 'AD User Trusted'
id = ARGV[0]

jndi = Hashtable.new({
    'java.naming.provider.url' => 't3://10.178.92.85:8003/oim',
    'java.naming.factory.initial' => 'weblogic.jndi.WLInitialContextFactory'
})

 
xlclient = XLAPIClient.new
#xlclient.passwordLogin('xelsysadm', 'Welcome1')
xlclient.passwordLoginWithDiscovery('xelsysadm', 'Welcome1', jndi)

jobName = xlclient.getRandomString(6)
jobID = rand(1000)

ContextManager.pushContext(jobID.to_s, ContextManager::ContextTypes::RECON, "Setup")
ContextManager.setValue("JOBHISTORYID", ContextAwareNumber.new(jobID), true)
ContextManager.setValue("JOBNAME", ContextAwareString.new(jobName))

reconIntf = xlclient.getUtility('reconsvc')

reconHash = {
    'User ID' => id
}

reconMap = HashMap.new(reconHash)

t1 = System.currentTimeMillis
rceKey = reconIntf.createDeleteReconciliationEvent(objName, reconMap)

reconIntf.callingEndOfJobAPI()

puts "Created delete recon event with key = #{rceKey}" 

xlclient.logout
System.exit 0
