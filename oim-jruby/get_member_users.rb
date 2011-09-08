require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class('java.lang.String') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


ugpName = 'testgrp'


xlclient = XLAPIClient.new
xlclient.defaultLogin

grpIntf = xlclient.getUtility('grp')

ugpKey = xlclient.getGrpKey(ugpName)
puts "Group key = #{ugpKey}"

#rs = grpIntf.getMemberUsers(ugpKey)
rs = grpIntf.getAllMemberUsers(ugpKey)
xlclient.printRS(rs)

xlclient.close
System.exit 0
