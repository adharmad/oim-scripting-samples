require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


numUsers = 1000
prefix = 'hundred'

xlclient = XLAPIClient.new
xlclient.defaultLogin

orgIntf = xlclient.getUtility('org')

for i in (1..numUsers)
    orgHash = {
        'Organizations.Organization Name' => prefix + i.to_s,
        'Organizations.Type' => 'Company'
    }

    orgMap = HashMap.new(orgHash)

    t1 = System.currentTimeMillis
    actKey = orgIntf.createOrganization(orgMap)
	t2 = System.currentTimeMillis

    delta = t2-t1
    puts "Created org with key = #{actKey} time = #{delta}"
end

xlclient.close
System.exit 0
