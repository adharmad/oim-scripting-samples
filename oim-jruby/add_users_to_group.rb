require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


xlclient = XLAPIClient.new
xlclient.defaultLogin
grpIntf = xlclient.getUtility('grp')

    
grpKeys = []
usrLogin = 'BBB16'
#grpKey = xlclient.getGrpKey(grpName)
usrKey = xlclient.getUsrKey(usrLogin)

puts "usrKey = #{usrKey}"
grpKeys.each do |grpKey|
    puts "grpKey = #{grpKey}"
    grpIntf.addMemberUsers(grpKey, usrKey)
end

xlclient.close
System.exit 0
