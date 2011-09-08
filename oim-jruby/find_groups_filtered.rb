require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'

xlclient = XLAPIClient.new

xlclient.defaultLogin

grpIntf = xlclient.getUtility('grp')

grpMap = HashMap.new({
    'Groups.Name' => 'a*'
})

retAttrs = ["Groups.Key"].to_java(:string)
filterSort = ["Groups.Key"].to_java(:string)

grpRS = grpIntf.findGroupsFiltered(grpMap, retAttrs, 1, 1, filterSort, true)

xlclient.printRS(grpRS)

xlclient.close
System.exit 0

