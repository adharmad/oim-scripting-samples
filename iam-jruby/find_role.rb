require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
include_class 'java.util.HashSet'
include_class 'java.util.ArrayList'
include_class 'java.util.Hashtable'

include_class 'oracle.iam.platform.entitymgr.vo.SearchCriteria'
include_class 'oracle.iam.identity.utils.SearchCriteriaUtils'
include_class 'oracle.iam.identity.rolemgmt.vo.Role'


attributes = ArrayList.new
attributes.add('Role Name')

comparators = ArrayList.new
comparators.add('equals')

values = ArrayList.new
values.add('testrole')
#values.add('*')
 
conjunctions = ArrayList.new
conjunctions.add('and')

sc = SearchCriteriaUtils.toSearchCriteria(attributes, values, comparators, conjunctions)

retSet = HashSet.new
retSet.add('Role Key')
retSet.add('Role Name')
retSet.add('Role Email')
retSet.add('Role Description')


xlclient = XLAPIClient.new
xlclient.defaultLogin

roleMgr = xlclient.getUtility('rolemgr')
 
t1 = System.currentTimeMillis

roles = roleMgr.search(sc, retSet, nil)
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
