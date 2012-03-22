require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
 
 
login = 'XELSYSADM'
 
xlclient = XLAPIClient.new
xlclient.defaultLogin
 
usrIntf = xlclient.getUtility('usr')
 
usrHash = {
    #'Users.User ID' => login 
    'Users.Password' => 'Welcome1'
}
 
usrMap = HashMap.new(usrHash)
 
rs = usrIntf.findUsers(usrMap)

xlclient.printRS(rs)
 
xlclient.logout
System.exit 0

