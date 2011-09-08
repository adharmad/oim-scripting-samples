require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

usrPrefix = 'STEVEJOBS'
objName = 'offline1'
numUsers = 50

xlclient = XLAPIClient.new
xlclient.defaultLogin

usrIntf = xlclient.getUtility('usr')
fiIntf = xlclient.getUtility('fi')

for idx in (2..numUsers)
    usrLogin = usrPrefix + idx.to_s
    usrKey = xlclient.getUsrKey(usrLogin)
    objKey = xlclient.getObjKey(objName)

    t1 = System.currentTimeMillis
    oiuKey = usrIntf.provisionObject(usrKey, objKey)
    t2 = System.currentTimeMillis

    delta = t2-t1
    puts "Provisioned user with key = #{usrKey} resource oiu_key = #{oiuKey} time = #{delta}"

end

xlclient.close
System.exit 0
