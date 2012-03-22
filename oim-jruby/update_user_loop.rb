require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


numIter = 100
prefix = 'HUNDRED'

for i in (1..numIter)
  xlclient = XLAPIClient.new
  xlclient.defaultLogin
  usrIntf = xlclient.getUtility('usr')

  userLogin = prefix + i.to_s

  usrMap = HashMap.new({
    'Users.User ID' => userLogin
  })

  filter = ['Users.Key', 'Users.User ID', 'Users.Row Version'].to_java(:String)
  rs = usrIntf.findUsersFiltered(usrMap, filter)

  updateMap = HashMap.new({
    'Users.First Name' => userLogin + 'Fst' + i.to_s,
    'Users.Last Name' => userLogin + 'Lst' + i.to_s
  })

  t1 = System.currentTimeMillis
  usrIntf.updateUser(rs, updateMap)
  t2 = System.currentTimeMillis
  delta = t2-t1
  puts "Updated user with login = #{userLogin} time = #{delta}"

  xlclient.close

  sleep(5)
end

System.exit 0
