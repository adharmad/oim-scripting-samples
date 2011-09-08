require 'java'
require 'xlclient'


include_class 'java.io.File'
include_class 'java.io.FileInputStream'
include_class 'java.security.KeyStore'
include_class 'java.security.PrivateKey'
include_class 'java.security.Provider'
include_class 'java.security.Security'
include_class 'java.security.Signature'
include_class 'java.security.SignedObject'
include_class 'java.security.cert.X509Certificate'
include_class 'java.util.HashMap'
include_class 'java.util.HashSet'
include_class 'java.util.ArrayList'
include_class 'java.util.Properties'

include_class 'java.lang.System'

include_class('com.thortech.xl.crypto.tcSignatureMessage'){|package,name| "OIM#{name}"}
include_class 'com.thortech.xl.util.config.ConfigurationClient'
include_class('Thor.API.tcUtilityFactory'){|package,name| "OIM#{name}"}

ksFile = 'xlclient.jks'
ksPass = 'dead_line'
kPass = 'dead_line'
providerClsName = 'sun.security.provider.Sun'
ksType = 'JKS'
keyAlias = 'xlclient'
sigAlgo = 'SHA1withRSA'
sigProviderClsName = 'sun.security.provider.Sun'

sigProviderClass = java::lang::Class.forName(sigProviderClsName)
sigProvider = sigProviderClass.newInstance
sigEngine = Signature.getInstance(sigAlgo, sigProvider.getName)

providerClass = java::lang::Class.forName(providerClsName)
provider = providerClass.newInstance
Security.addProvider(provider)

ks = Keystore.getInstance(ksType, provider.getName())
ks.load(FileInputStream.new(ksFile), ksPass.toCharArray())

pvtKey = ks.getKey(keyAlias, kPass.toCharArray())
cert = ks.getCertificate(keyAlias)

so = SignedObject.new("xelsysadm", pvtKey, sigEngine)

puts "Performing signature login"

sigMsg = OIMtcSignatureMessage.new(so, cert)
jndi = ConfigurationClient.getComplexSettingByPath('Discovery.CoreServer').getAllSettings()
factory = OIMtcUtilityFactory.new(jndi, sigMsg)
usrIntf = factory.getUtility('Thor.API.Operations.tcUserOperationsIntf')

usrMap = HashMap.new({ })
retAttrs = ["Users.User ID","Users.Key","Users.First Name", "Users.Last
Name", "USR_UDF_TEST"].to_java(:string)

usrRS = usrIntf.findAllUsersFiltered(usrMap, retAttrs)
xlclient.printRS(usrRS)

System.exit 0
