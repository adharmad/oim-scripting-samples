require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
include_class 'java.util.HashSet'
include_class 'java.util.ArrayList'
include_class 'java.util.Hashtable'

include_class 'oracle.iam.platform.entitymgr.vo.SearchCriteria'
include_class 'oracle.iam.provisioning.vo.ApplicationInstance'


#attributes = ArrayList.new
#attributes.add(ApplicationInstance.APPINST_NAME)
#
#comparators = ArrayList.new
#comparators.add('like')
#
#values = ArrayList.new
##values.add('babar1')
#values.add('*')
# 
#conjunctions = ArrayList.new
#conjunctions.add('and')
#
#sc = SearchCriteriaUtils.toSearchCriteria(attributes, values, comparators, conjunctions)

sc = SearchCriteria.new(ApplicationInstance::APPINST_NAME, "*", SearchCriteria::Operator::AND)

xlclient = XLAPIClient.new
xlclient.defaultLogin
#xlclient.passwordLogin('test1', 'Welcome1')
#xlclient.passwordLoginWithDiscovery('xelsysadm', 'Welcome1', jndi)

aiSvc = xlclient.getUtility('aisvc')

aiLst = aiSvc.findApplicationInstance(sc, HashMap.new({}))

aiLst.each { |ai|
    aiName = ai.getApplicationInstanceName
    roName = ai.getObjectName
    itresName = ai.getItResourceName
    puts "#{aiName} : #{roName} : #{itresName}"
}

xlclient.logout
System.exit 0
