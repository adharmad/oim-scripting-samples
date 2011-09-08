require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.util.HashMap'
include_class 'java.lang.System'

include_class 'javax.management.MBeanServerConnection'
include_class 'javax.management.ObjectName'
include_class 'javax.management.remote.JMXConnector'
include_class 'javax.management.remote.JMXConnectorFactory'
include_class 'javax.management.remote.JMXServiceURL'
include_class 'javax.naming.Context'

#api_to_call = 'seedFusionAPPID'
api_to_call = 'seedAllMLSLanguages'
#api_to_call = 'register'
#api_to_call = 'seedRoleCategories'

appid_mbean_name = 'oracle.iam:type=IAMAppRuntimeMBean,name=APPIDSeedingMBean,Application=oim,ApplicationVersion=11.1.1.3.0'
mls_mbean_name = 'oracle.iam:type=IAMAppRuntimeMBean,name=MLSLanguageSeedingMBean,Application=oim,ApplicationVersion=11.1.1.3.0'
callback_mbean_name = 'oracle.iam:type=IAMAppRuntimeMBean,name=NotificationPolicyConfigMBean,Application=oim,ApplicationVersion=11.1.1.3.0'
roleseed_mbean_name = 'oracle.iam:type=IAMAppRuntimeMBean,name=RoleCategorySeedMBean,Application=oim,ApplicationVersion=11.1.1.3.0'

callback_policy_fragment="<callbackConfiguration xmlns=\"http://www.oracle.com/schema/oim/callback_config\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.oracle.com/schema/oim/callback_config\" >
     <policy>
         <policyName>anotherrandompolicy</policyName>
         <entityType>User</entityType>
         <operation>Create</operation>
         <description>Policy to create  a user in the store</description>
         <provisioningSteps>
             <postProcessing>
                 <asyncSteps>
                    <stepName>http://stadd46.us.oracle.com:7001/PostProcessingPluginRequestPortImpl/PostProcessingPluginRequestPortImpl</stepName>
                 </asyncSteps>
             </postProcessing>
             <completion>
                  <syncSteps>
                      <stepName>http://dadvml0150.us.oracle.com:17005/CompletionPluginPortImpl/CompletionPluginPortImpl</stepName>
                  </syncSteps>
              </completion>
         </provisioningSteps>
     </policy>
     </callbackConfiguration>"


protocol = 't3'
jndi_root = '/jndi/'
wlserver = 'weblogic.management.mbeanservers.runtime'
host = 'localhost'
port = 7001

#adminUser = 'xelsysadm'
#adminPassword = 'Welcome1'
adminUser = 'weblogic'
adminPassword = 'weblogic1'

url = JMXServiceURL.new(protocol, host, port, jndi_root + wlserver)

envMap = HashMap.new({
    Context::SECURITY_PRINCIPAL => adminUser,
    Context::SECURITY_CREDENTIALS => adminPassword,
    JMXConnectorFactory::PROTOCOL_PROVIDER_PACKAGES => 'weblogic.management.remote'
})
 
connector = JMXConnectorFactory.connect(url, envMap)
conn = connector.getMBeanServerConnection()
puts "Got mbean server connection"
name = ObjectName.new(mls_mbean_name)

#sig = ["java.lang.String"].to_java(:string)
#params = [ARGV[0]].to_java(:string)
sig = [].to_java(:string)
params = [].to_java(:string)

puts "Before invoking API"

ret = conn.invoke(name, api_to_call, params, sig)
puts "ret = #{ret}"

System.exit 0
