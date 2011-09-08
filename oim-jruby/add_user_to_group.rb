require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


xlclient = XLAPIClient.new
xlclient.defaultLogin
grpIntf = xlclient.getUtility('grp')

    
grpName = 'JACK_polgrp1'
usrLogin = 'JACKY1'
grpKey = xlclient.getGrpKey(grpName)
usrKey = xlclient.getUsrKey(usrLogin)

puts "usrKey = #{usrKey}"
puts "grpKey = #{grpKey}"

grpIntf.addMemberUser(grpKey, usrKey)

xlclient.close
System.exit 0
