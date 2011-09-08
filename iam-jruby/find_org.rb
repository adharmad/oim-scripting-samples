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
include_class 'oracle.iam.identity.orgmgmt.vo.Organization'


attributes = ArrayList.new
attributes.add('Organization Name')

comparators = ArrayList.new
comparators.add('equals')

values = ArrayList.new
values.add('Xellerate Users')
 
conjunctions = ArrayList.new
conjunctions.add('and')

sc = SearchCriteriaUtils.toSearchCriteria(attributes, values, comparators, conjunctions)

retSet = HashSet.new
retSet.add('act_key')
retSet.add('Organization Name')


xlclient = XLAPIClient.new
xlclient.defaultLogin

orgMgr =  xlclient.getUtility('orgmgr')
 
t1 = System.currentTimeMillis

orgs = orgMgr.search(sc, retSet, nil)
orgs.each { |org|
    entityId = org.getEntityId()
    actKey = org.getAttribute('act_key')
    orgName = org.getAttribute('Organization Name')
    puts "#{entityId} : #{actKey} : #{orgName}"
}

t2 = System.currentTimeMillis
 
delta = t2-t1

xlclient.logout
System.exit 0
