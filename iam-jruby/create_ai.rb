require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
 
include_class 'oracle.iam.provisioning.vo.ApplicationInstance'
 
aiName = ARGV[0]
objName = 'test1'
itresName = 'test1_6'

xlclient = XLAPIClient.new
xlclient.defaultLogin

aiSvc = xlclient.getUtility('aisvc')

objKey = xlclient.getObjKey(objName)
itresKey = xlclient.getITResInstKey(itresName)

ai = ApplicationInstance.new(aiName, aiName, 'test desc', objKey, itresKey, ' ', ' ')
ai1 = aiSvc.addApplicationInstance(ai)

aiKey = ai1.getApplicationInstanceKey

puts "Created app instance name = #{aiName} key = #{aiKey}"

xlclient.logout 
System.exit 0
