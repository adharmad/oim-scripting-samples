require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


numUsers = 200
prefix = 'magnus'
objName = 'Xellerate User'

xlclient = XLAPIClient.new
xlclient.defaultLogin

reconIntf = xlclient.getUtility('recon')

for i in (1..numUsers)

    login = prefix + i.to_s
    reconHash = {
        'login' => login,
        'first' => login + '_First',
        'last' => login + '_Last',
        'role' => 'Full-Time',
        'xltype' => 'End-User',    
        'org' => 'Xellerate Users',
        'middle' => login + '_Middle'
    }

    reconMap = HashMap.new(reconHash)

    t1 = System.currentTimeMillis
    rceKey = reconIntf.createReconciliationEvent(objName, reconMap, true)
    t2 = System.currentTimeMillis

    delta = t2-t1
    puts "Created recon_event with key = #{rceKey} time = #{delta}"
end

xlclient.close
System.exit 0
