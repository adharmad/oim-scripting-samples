require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

usrPrefix = 'TEST'
objName = 'OID User'
numUsers = 10

xlclient = XLAPIClient.new
xlclient.defaultLogin

usrIntf = xlclient.getUtility('usr')

for idx in (2..numUsers)
    usrLogin = usrPrefix + idx.to_s
    usrKey = xlclient.getUsrKey(usrLogin)
    objKey = xlclient.getObjKey(objName)

    oiuKey = usrIntf.provisionObject(usrKey, objKey)

    puts "Provisioned user with key = #{usrKey} resource oiu_key = #{oiuKey}"

end

xlclient.close
System.exit 0
