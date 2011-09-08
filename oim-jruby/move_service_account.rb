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
usrKey = 4922

usrIntf.moveServiceAccount(oiuKey, usrKey)
puts "moved service account oiu_key=#{oiuKey} to a usr_key=#{usrKey}"

xlclient.close
System.exit 0
