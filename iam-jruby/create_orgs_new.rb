require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'

include_class 'oracle.iam.identity.orgmgmt.vo.Organization'

orgPref = 'testorg'
count = 10
 
xlclient = XLAPIClient.new
xlclient.defaultLogin
 
orgMgr = xlclient.getUtility('orgmgr')

for i in (1..count)
    org = Organization.new
    org.setAttribute('Organization Name', orgPref + i.to_s)
    org.setAttribute('Organization Customer Type', 'Department')
    org.setAttribute('Organization Status', 'Active')

    t1 = System.currentTimeMillis
    orgKey = orgMgr.createOrganization(org)
    t2 = System.currentTimeMillis
 
    delta = t2-t1
    puts "Created organization with key = #{orgKey} time = #{delta}"
end

xlclient.logout 
System.exit 0
