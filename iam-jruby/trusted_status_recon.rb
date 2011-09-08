require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'

include_class 'oracle.iam.platform.context.ContextAwareNumber'
include_class 'oracle.iam.platform.context.ContextAwareString'
include_class 'oracle.iam.platform.context.ContextManager'
include_class 'oracle.iam.platform.context.ContextManager'
 
 
objName = 'Xellerate User'
#id = 'FOO003'
id = ARGV[0]
 
xlclient = XLAPIClient.new
#xlclient.defaultLogin
xlclient.passwordLogin('xelsysadm', 'Welcome1')

jobName = xlclient.getRandomString(6)
jobID = rand(1000)

ContextManager.pushContext(jobID.to_s, ContextManager::ContextTypes::RECON, "Setup")
ContextManager.setValue("JOBHISTORYID", ContextAwareNumber.new(jobID), true)
ContextManager.setValue("JOBNAME", ContextAwareString.new(jobName))

#reconIntf = xlclient.getUtility('recon')
reconIntf = xlclient.getUtility('reconsvc')

reconHash = {
    'uid' => id,
    'status' => 'Disabled'
}

reconMap = HashMap.new(reconHash)

t1 = System.currentTimeMillis
rceKey = reconIntf.createReconciliationEvent(objName, reconMap, true)

reconIntf.callingEndOfJobAPI()

puts "Created recon event with key = #{rceKey}" 

xlclient.logout
System.exit 0
