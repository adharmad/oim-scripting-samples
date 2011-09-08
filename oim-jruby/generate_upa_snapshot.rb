require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'

usrKey = 11

xlclient = XLAPIClient.new
xlclient.passwordLogin('xelsysadm', 'Welcome1')

auditIntf = xlclient.getIntf('upa')

auditIntf.generateSnapshot(usrKey)

puts "done!"

xlclient.logout
System.exit 0
