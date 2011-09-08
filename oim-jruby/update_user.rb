require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

usr_key = 932
change = 'change_this'

xlclient = XLAPIClient.new
xlclient.defaultLogin

usrIntf = xlclient.getUtility('usr')

usrMap = HashMap.new({
    'Users.Key' => usr_key.to_s
})

filter = ['Users.Key', 'Users.User ID', 'Users.Row Version'].to_java(:String)
rs = usrIntf.findUsersFiltered(usrMap, filter)

updateMap = HashMap.new({
    'Users.First Name' => 'pp',
    'Users.Last Name' => 'qq',
    'Users.Middle Name' => 'rr'
    'Users.Email' => change + '_email@example.com',
    'Organizations.Key' => '100'
    #'USR_UDF_REGULAR' => change + '_regular',
    #'USR_UDF_ENCRYPTED' => change + '_encrypted'
})

t1 = System.currentTimeMillis
usrIntf.updateUser(rs, updateMap)
t2 = System.currentTimeMillis
delta = t2-t1
puts "Updated user with key = #{usr_key} time = #{delta}"

xlclient.close
System.exit 0
