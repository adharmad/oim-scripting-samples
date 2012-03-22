require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'

include_class 'oracle.iam.identity.orgmgmt.vo.Organization'

orgname = ARGV[0]
 
xlclient = XLAPIClient.new
xlclient.defaultLogin
 
orgMgr = xlclient.getUtility('orgmgr')

org = Organization.new
org.setAttribute('Organization Name', orgname)
org.setAttribute('Organization Customer Type', 'Department')
org.setAttribute('Organization Status', 'Active')

t1 = System.currentTimeMillis
orgKey = orgMgr.create(org)
t2 = System.currentTimeMillis
 
delta = t2-t1
puts "Created organization with key = #{orgKey} time = #{delta}"

xlclient.logout 
System.exit 0
