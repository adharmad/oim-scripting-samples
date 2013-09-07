require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

accountID = ARGV[0].to_i
newPassword = ARGV[1]

xlclient = XLAPIClient.new
xlclient.defaultLogin

provSvc = xlclient.getUtility('provsvc')

t1 = System.currentTimeMillis
provSvc.changeAccountPassword(accountID, java.lang.String.new(newPassword).toCharArray)
t2 = System.currentTimeMillis

delta = t2-t1
puts "Changed password of accountID = #{accountID} time = #{delta}"

xlclient.logout
System.exit 0

