require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class('java.lang.String') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


xlclient = XLAPIClient.new
xlclient.defaultLogin

usrIntf = xlclient.getUtility('usr')

usrMap = HashMap.new({
    'Users.User ID' => 'X*'
})

filter = ['Users.Key', 'Users.User ID'].to_java(:String)

rs = usrIntf.findUsersFiltered(usrMap, filter)
xlclient.printRS(rs)

xlclient.close
System.exit 0
