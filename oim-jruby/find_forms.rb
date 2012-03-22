require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.lang.Thread' 
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

xlclient = XLAPIClient.new
xlclient.defaultLogin

fdIntf = xlclient.getUtility('fd')

formHash = {
  'Structure Utility.Table Name' => 'UD_XXXX'
}

formMap = HashMap.new(formHash)


rs = fdIntf.findForms(formMap)

xlclient.printRS(rs)

xlclient.close
System.exit 0
