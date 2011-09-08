require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'

include_class 'oracle.iam.platform.context.ContextAwareNumber'
include_class 'oracle.iam.platform.context.ContextAwareString'
include_class 'oracle.iam.platform.context.ContextManager'
include_class 'oracle.iam.platform.context.ContextManager'
 

rolePrefix = ARGV[0]
count = ARGV[1].to_i

profileName = "fusionapp"

xlclient = XLAPIClient.new
xlclient.passwordLogin('xelsysadm', 'Welcome1')

jobName = xlclient.getRandomString(6)
jobID = rand(1000)

ContextManager.pushContext(jobID.to_s, ContextManager::ContextTypes::RECON, "Setup")
ContextManager.setValue("JOBHISTORYID", ContextAwareNumber.new(jobID), true)
ContextManager.setValue("JOBNAME", ContextAwareString.new(jobName))

reconIntf = xlclient.getUtility('reconsvc')

for i in (1..count)
    roleName = rolePrefix + i.to_s
    
    mlsNameHash = {
        'en' => roleName, 
        'base' => roleName
    }

    roleCategory = ''
    if i%2 == 0 then
        roleCategory = 'Default'
    else
        roleCategory = 'Wrong and invalid'
    end

    reconHash = {
        'role name' => roleName,
        'role display name' => HashMap.new(mlsNameHash),
        'role description' => roleName + ' test description',
        'role guid' => roleName,
        'role dn' => roleName + '_dn',
        'role category' => roleCategory
    }

    reconMap = HashMap.new(reconHash)

    t1 = System.currentTimeMillis
    rceKey = reconIntf.createReconciliationEvent(profileName, reconMap, true)
    puts "Created recon event with key = #{rceKey}" 
end

reconIntf.callingEndOfJobAPI()

xlclient.logout
System.exit 0
