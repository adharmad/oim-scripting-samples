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
 
 
objName = 'Xellerate User'
id = ARGV[0]
numEvents = ARGV[1].to_i
 
xlclient = XLAPIClient.new
xlclient.passwordLogin('xelsysadm', 'Welcome1')

jobName = xlclient.getRandomString(6)
jobID = rand(1000)

ContextManager.pushContext(jobID.to_s, ContextManager::ContextTypes::RECON, "Setup")
ContextManager.setValue("JOBHISTORYID", ContextAwareNumber.new(jobID), true)
ContextManager.setValue("JOBNAME", ContextAwareString.new(jobName))

reconIntf = xlclient.getUtility('reconsvc')

fileName = 'prov2-timing.csv'

File.open(fileName, 'w') do |f|  
    for i in 1..numEvents
        login = id + i.to_s
        reconHash = {
            'login' => login,
            'first' => login + '_Fisrt',
            'last' => login + '_Last',
            'role' => 'Full-Time',
            'xltype' => 'End-User',
            'org' => 'dummy1'
        }

        reconMap = HashMap.new(reconHash)

        t1 = System.currentTimeMillis
        rceKey = reconIntf.createReconciliationEvent(objName, reconMap, true)
        t2 = System.currentTimeMillis
    
        delta = t2-t1
        f.puts "#{rceKey} #{delta}"
    end
end

reconIntf.callingEndOfJobAPI()

xlclient.logout
System.exit 0
