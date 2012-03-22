require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'

include_class 'oracle.iam.platform.context.ContextAwareNumber'
include_class 'oracle.iam.platform.context.ContextAwareString'
include_class 'oracle.iam.platform.context.ContextManager'
include_class 'oracle.iam.platform.context.ContextManager'
 
 
id = ARGV[0]
objName = 'AD User'

jndi = Hashtable.new({
    'java.naming.provider.url' => 't3://10.178.92.85:8003/oim',
    'java.naming.factory.initial' => 'weblogic.jndi.WLInitialContextFactory'
})

xlclient = XLAPIClient.new
xlclient.passwordLoginWithDiscovery('xelsysadm', 'Welcome1', jndi)

jobName = xlclient.getRandomString(6)
jobID = rand(1000)

ContextManager.pushContext(jobID.to_s, ContextManager::ContextTypes::RECON, "Setup")
ContextManager.setValue("JOBHISTORYID", ContextAwareNumber.new(jobID), true)
ContextManager.setValue("JOBNAME", ContextAwareString.new(jobName))

#reconIntf = xlclient.getUtility('recon')
reconIntf = xlclient.getUtility('reconsvc')

reconHash = {
    'displayName' => id,
    'City' => 'SFO',
    'P.O.Box' => '1234',
    'Office' => 'HELLO',
    'Organization Name' => '4~OU=sandhya,DC=parent,DC=com',
    'Fax' => '123',
    'State' => '345',
    'Pager' => '213123',
    'Company' => 'company',
    'Zip' => '94118',
    'Middle Name' => 'xx',
    'UserPrincipalName' => id + '@',
    'Email' => id + '@oracle.com',
    'Mobile' => 'asdasd',
    'objectGUID' => '1c15720e426bb84fae4098d5514d6085',
    'Telephone Number' => '123',
    'Street' => 'test',
    'Department' => 'mydept',
    'Title' => 'mr',
    'First Name' => id + 'first',
    'name' => id,
    'IP Phone' => 'none',
    'cn' => id + 'first ' + id + 'last',
    'IT Resource' => '4',
    'User ID' => id,
    'Last Name' => id + 'last',
    'Country' => 'US',
    'Home Phone' => '666'
}

reconMap = HashMap.new(reconHash)

t1 = System.currentTimeMillis
rceKey = reconIntf.createReconciliationEvent(objName, reconMap, true)

reconIntf.callingEndOfJobAPI()

puts "Created recon event with key = #{rceKey}" 

xlclient.logout
System.exit 0
