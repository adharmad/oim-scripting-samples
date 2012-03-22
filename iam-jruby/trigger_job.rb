require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
 
 
jobName = 'Foo'
 
xlclient = XLAPIClient.new
xlclient.passwordLogin('xelsysadm', 'Welcome1')
 
schSvc = xlclient.getUtility('sch')
 
t1 = System.currentTimeMillis
schSvc.triggerNow(jobName)
schSvc.triggerNow(jobName)
schSvc.triggerNow(jobName)
schSvc.triggerNow(jobName)
schSvc.triggerNow(jobName)
t2 = System.currentTimeMillis
 
delta = t2-t1
puts "Triggered job #{jobName} time = #{delta}"

xlclient.logout 
System.exit 0
