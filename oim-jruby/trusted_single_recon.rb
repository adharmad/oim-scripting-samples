require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


userID = 'ZZZ5'
objName = 'Xellerate User'
change = 'gulliver'

xlclient = XLAPIClient.new
xlclient.defaultLogin

reconIntf = xlclient.getUtility('recon')

reconHash = {
    'login' => userID,
    'first' => userID + '_first_' + change,
    'last' => userID + '_last_' + change,
    'role' => 'Full-Time',
    'xltype' => 'End-User',    
    'org' => 'Xellerate Users',
    'middle' => userID + '_middle_' + change,
    'regular' => userID + '_regular_' + change,
    'encrypted' => userID + '_encrypted_' + change
}

reconMap = HashMap.new(reconHash)

t1 = System.currentTimeMillis
rceKey = reconIntf.createReconciliationEvent(objName, reconMap, true)
t2 = System.currentTimeMillis

delta = t2-t1
puts "Created recon event with key = #{rceKey} time = #{delta}"

xlclient.close
System.exit 0
