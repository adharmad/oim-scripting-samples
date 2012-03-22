require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.lang.Thread' 
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

pName = 'UD_PAPA3'

xlclient = XLAPIClient.new
xlclient.defaultLogin

fdIntf = xlclient.getUtility('fd')

sdkHash = {
  'Structure Utility.Table Name' => pName,
  'Structure Utility.Form Type' => 'P',
  'Structure Utility.Description' => 'description',
  'Structure Utility.Form Description' => 'form descrip',
  'Structure Utility.Note' => 'hello form'
}

sdkMap = HashMap.new(sdkHash)

pSdkKey = xlclient.getFormKey(pName)


fdIntf.createForm(sdkMap)

xlclient.close
System.exit 0
