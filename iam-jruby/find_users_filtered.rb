require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
 
 
login = ARGV[0]
 
xlclient = XLAPIClient.new
xlclient.defaultLogin
 
usrIntf = xlclient.getIntf('usr')

usrMap = HashMap.new({
    #    'Users.User ID' => 'RAMBO1'
    'Users.Middle Name' => ''
})
retAttrs = ["Users.User ID","Users.Key","Users.First Name", "Users.Last
Name", "USR_UDF_TEST"].to_java(:string)

usrRS = usrIntf.findAllUsersFiltered(usrMap, retAttrs)
 
xlclient.printRS(usrRS)

xlclient.logout
System.exit 0

