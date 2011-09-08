require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class('java.lang.Long') {|package,name| "J#{name}"}

include_class 'oracle.iam.platform.context.ContextAwareNumber'
include_class 'oracle.iam.platform.context.ContextAwareString'
include_class 'oracle.iam.platform.context.ContextManager'
include_class 'oracle.iam.platform.context.ContextManager'
 

reKey = ARGV[0]

xlclient = XLAPIClient.new
xlclient.passwordLogin('xelsysadm', 'Welcome1')

eventMgmtSvc = xlclient.getUtility('reconevent')
eventList = JArrayList.new
#eventList.add(JLong.new(reKey))
eventList.add(reKey.to_s)


t1 = System.currentTimeMillis
rceKey = eventMgmtSvc.performBulkAction('ReEvaluateEvent', nil, eventList)

puts "Re-tried recon event with key = #{reKey}" 

xlclient.logout
System.exit 0
