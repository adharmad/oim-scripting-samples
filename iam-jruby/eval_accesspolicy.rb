require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
 
usrKey = ARGV[0]

xlclient = XLAPIClient.new
xlclient.defaultLogin
 
apSvc = xlclient.getUtility('apsvc')

apSvc.evalutePoliciesForUser(usrKey)
 
puts "Evaluated policies for user key = #{usrKey}"

xlclient.logout 
System.exit 0
