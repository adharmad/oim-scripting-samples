require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.ArrayList'

#include_class('oracle.iam.platform.authopss.api.EntityPublicationService')
include_class('oracle.iam.platform.authopss.api.PolicyConstants')
include_class('oracle.iam.platform.authopss.vo.EntityPublication')
include_class('oracle.iam.platform.authopss.api.PolicyConstants')
#include_class('oracle.iam.platform.authopss.api.PolicyConstants.Resources')


role_key = '22'

xlclient = XLAPIClient.new
xlclient.defaultLogin

epsSvc = xlclient.getUtility('eps')

ep = EntityPublication.new(role_key, PolicyConstants::Resources::ROLE, 1, false)

epsList = ArrayList.new
epsList.add(ep)
#epsList = [ep]

epsSvc.addEntityPublications(epsList)

puts "completed entity publication"

xlclient.logout 
System.exit 0
