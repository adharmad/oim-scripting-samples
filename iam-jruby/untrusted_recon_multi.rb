require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'

include_class 'oracle.iam.platform.context.ContextAwareNumber'
include_class 'oracle.iam.platform.context.ContextAwareString'
include_class 'oracle.iam.platform.context.ContextManager'
include_class 'oracle.iam.platform.context.ContextManager'
 
 
prefix = ARGV[0]
objName = 'R2'
count = 1000
 
xlclient = XLAPIClient.new
xlclient.defaultLogin
#xlclient.passwordLogin('xelsysadm', 'Welcome1')

jobName = xlclient.getRandomString(6)
jobID = rand(1000)

ContextManager.pushContext(jobID.to_s, ContextManager::ContextTypes::RECON, "Setup")
ContextManager.setValue("JOBHISTORYID", ContextAwareNumber.new(jobID), true)
ContextManager.setValue("JOBNAME", ContextAwareString.new(jobName))

#reconIntf = xlclient.getUtility('recon')
reconIntf = xlclient.getUtility('reconsvc')

for i in (1..count)
    id = prefix + i.to_s

    reconHash = {
        'itres' => '17',
        'login' => id,
        'first' => id.to_s + '_first',
        'middle' => id.to_s + '_middle',
        'last' => id.to_s + '_last',
        'email' => id.to_s + '@oracle.com'
    }

    reconMap = HashMap.new(reconHash)

    rceKey = reconIntf.createReconciliationEvent(objName, reconMap, true)
    puts "Created recon event with key = #{rceKey}" 

end

reconIntf.callingEndOfJobAPI()


xlclient.logout
System.exit 0
