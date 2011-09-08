require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'

include_class 'oracle.iam.platform.context.ContextAwareNumber'
include_class 'oracle.iam.platform.context.ContextAwareString'
include_class 'oracle.iam.platform.context.ContextManager'
include_class 'oracle.iam.platform.context.ContextManager'
 
 
objName = 'ross'
id = 'FOO003'
 
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
    'aa' => 'a',
    'bb' => 'b',
    'cc' => 'c'
}

reconMap = HashMap.new(reconHash)

t1 = System.currentTimeMillis
rceKey = reconIntf.createReconciliationEvent(objName, reconMap, false)

# first child table entry
childHash = {
    'child1' => 'entry1',
    'child2' => 'val111'
}

childMap = HashMap.new(childHash)
reconIntf.addMultiAttributeData(rceKey, 'rosschild', childMap)

# second child table entry
childHash = {
    'child1' => 'entry2',
    'child2' => 'val222'
}

childMap = HashMap.new(childHash)
reconIntf.addMultiAttributeData(rceKey, 'rosschild', childMap)


# second child table entry
childHash = {
    'child1' => 'entry3',
    'child2' => 'val333'
}

childMap = HashMap.new(childHash)
reconIntf.addMultiAttributeData(rceKey, 'rosschild', childMap)

reconIntf.finishReconciliationEvent(rceKey)

reconIntf.callingEndOfJobAPI()

puts "Created recon event with key = #{rceKey}" 

xlclient.logout
System.exit 0
