require 'java'
require 'xlclient'

module Java
    include_package 'com.oracle.xmlns.idm.identity.webservice.spmlservice'
    include_package 'oracle.iam.wsschema.model.spmlv2.core'
end 

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'

spmlSvc = Java::SPMLService.new
port = spmlSvc.getSPMLServiceProviderSoap()
body = Java::ListTargetsRequestType.new
body.setExecutionMode(Java::ExecutionModeType.SYNCHRONOUS)
response = port.spmlListTargetsRequest(body)

puts "Status: #{response.getStatus.to_s}" 

System.exit 0
