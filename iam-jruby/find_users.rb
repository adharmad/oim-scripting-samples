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
include_class 'oracle.iam.identity.vo.Identity'


attributes = ArrayList.new
attributes.add('User Login')

comparators = ArrayList.new
#comparators.add('begins_with')
comparators.add('equals')

values = ArrayList.new
values.add('FOO1')
#values.add('1')

conjunctions = ArrayList.new
conjunctions.add('or')

sc = SearchCriteriaUtils.toSearchCriteria(attributes, values, comparators, conjunctions)

retSet = HashSet.new
retSet.add('usr_key')
retSet.add('User Login')
retSet.add('First Name')
retSet.add('Last Name')
retSet.add('Email')
retSet.add('usr_password')
retSet.add('Status')

xlclient = XLAPIClient.new
xlclient.defaultLogin

usrMgr = xlclient.getUtility('usrmgr')
 
t1 = System.currentTimeMillis

users = usrMgr.search(sc, retSet, nil)
users.each { |user|
    entityId = user.getEntityId()
    login = user.getAttribute('User Login')
    first = user.getAttribute('First Name')
    last = user.getAttribute('Last Name')
    email = user.getAttribute('Email')
    passwd = user.getAttribute('usr_password')
    status = user.getAttribute('Status')
    puts "#{entityId} #{login} #{first} #{last} #{email} #{passwd} #{status}"
}

t2 = System.currentTimeMillis
 
delta = t2-t1

xlclient.logout
System.exit 0
