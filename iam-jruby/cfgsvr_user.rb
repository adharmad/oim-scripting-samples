require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'

include_class 'oracle.iam.configservice.vo.AttributeDefinition'
include_class 'oracle.iam.configservice.api.Constants'

xlclient = XLAPIClient.new
xlclient.defaultLogin
 
cfgMgr = xlclient.getUtility('cfgmgr')
attrMap = cfgMgr.getAttributes(Constants::Entity::USER)
attrMap.each do |name,attr_def|
    puts "#{name}"
end

xlclient.logout 
System.exit 0
