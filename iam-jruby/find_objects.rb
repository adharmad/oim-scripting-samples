require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
 
 
xlclient = XLAPIClient.new
xlclient.defaultLogin
 
objIntf = xlclient.getUtility('obj')
 
objHash = {
    'Objects.Name' => 'test1'
}
 
objMap = HashMap.new(objHash)
 
rs = objIntf.findObjects(objMap)

xlclient.printRS(rs)
 
xlclient.logout
System.exit 0

