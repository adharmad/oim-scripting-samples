require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


userID = 'LIMCA001'
objName = 'Xellerate User'

xlclient = XLAPIClient.new
xlclient.defaultLogin

reconIntf = xlclient.getUtility('recon')

reconHash = {
    'login' => userID,
    'first' => userID + '_pahila',
    'last' => 'CHANGED_GOGO',    
    'role' => 'Full-Time',
    'xltype' => 'End-User',    
    'org' => 'Xellerate Users',
    'mydate' => ''    
}

reconMap = HashMap.new(reconHash)

ret = reconIntf.ignoreEvent(objName, reconMap)

puts "Ignoreevent returned #{ret}"

xlclient.close
System.exit 0
