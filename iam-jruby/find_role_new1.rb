require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
include_class 'java.util.HashSet'
include_class 'java.util.ArrayList'

include_class 'oracle.iam.platform.entitymgr.vo.SearchCriteria'
include_class 'oracle.iam.identity.utils.SearchCriteriaUtils'
include_class 'oracle.iam.identity.rolemgmt.vo.Role'


attribute = 'Role Name'
value = 'SUBMIT AUTO APPROVAL REQUESTS ROLE'

sc = SearchCriteria.new(attribute, value, SearchCriteria::Operator::EQUAL)

retSet = HashSet.new
retSet.add('Role Key')
retSet.add('Role Name')
retSet.add('Role Email')
retSet.add('Role Description')

xlclient = XLAPIClient.new
xlclient.defaultLogin
#xlclient.passwordLogin('xelsysadm', 'password12')
 
roleMgr = xlclient.getUtility('rolemgr')
 
t1 = System.currentTimeMillis

roles = roleMgr.searchRole(sc, retSet, nil)
roles.each { |role|
    entityId = role.getEntityId()
    roleKey = role.getAttribute('Role Key')
    roleName = role.getAttribute('Role Name')
    email = role.getAttribute('Role Email')
    desc = role.getAttribute('Role Description')
    puts "#{entityId} : #{roleKey} : #{roleName} : #{email} : #{desc}"
}

t2 = System.currentTimeMillis
 
delta = t2-t1

xlclient.logout
System.exit 0
