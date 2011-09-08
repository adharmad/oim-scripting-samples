require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


login = ARGV[0]

xlclient = XLAPIClient.new
xlclient.defaultLogin
usrIntf = xlclient.getUtility('usr')

usrKey = xlclient.getUsrKey(login)

usrIntf.deleteUser(usrKey)
puts "deleted user #{login}"

xlclient.close
System.exit 0

