require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
 
 
queueName = ARGV[0]
 
xlclient = XLAPIClient.new
xlclient.defaultLogin
 
queueIntf = xlclient.getIntf('queue')
 
t1 = System.currentTimeMillis
queueKey = queueIntf.createQueue(queueName, "hello world", 0) 
t2 = System.currentTimeMillis
 
delta = t2-t1
puts "Created queue with key = #{queueKey} time = #{delta}"

xlclient.logout
System.exit 0

