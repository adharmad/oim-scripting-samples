require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


objName = 'recondd'

xlclient = XLAPIClient.new
xlclient.defaultLogin

reconIntf = xlclient.getUtility('recon')

hm1 = HashMap.new({
                    'itres' => '1241',
                    'uid' => 'MMM001',
                    'data' => 'random_data'
                  })

hm2 = HashMap.new({
                    'itres' => '1241',
                    'uid' => 'MMM002',
                    'data' => 'random_data'
                  })

hmArray = [hm1, hm2].to_java Java::java.util.HashMap

set = reconIntf.provideDeletionDetectionData(objName, hmArray)

set.each {|elem|
  puts "#{elem}"
}

rs = reconIntf.getMissingAccounts(objName, set)
xlclient.printRS(rs)


xlclient.close
System.exit 0
