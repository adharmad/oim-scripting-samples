require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


xlclient = XLAPIClient.new
xlclient.defaultLogin
usrIntf = xlclient.getUtility('usr')


oiuKey = 4101

usrIntf.changeToServiceAccount(oiuKey)
puts "changed account oiu_key=#{oiuKey} to a service account"

#usrIntf.changeFromServiceAccount(oiuKey)
#puts "changed account oiu_key=#{oiuKey} to a regular account"

xlclient.close
System.exit 0
