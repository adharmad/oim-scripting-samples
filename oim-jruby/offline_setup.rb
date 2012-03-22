require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

#usrPrefix = 'RAMRAHIM'
objName = 'offline3'
#numUsers = 1

usrPrefix = ARGV[0]
numUsers = ARGV[1].to_i

xlclient = XLAPIClient.new
xlclient.defaultLogin

usrIntf = xlclient.getUtility('usr')

for idx in (1..numUsers)
    usrLogin = usrPrefix + idx.to_s
    usrKey = xlclient.getUsrKey(usrLogin)
    objKey = xlclient.getObjKey(objName)

    oiuKey = usrIntf.provisionObject(usrKey, objKey)
    puts "Provisioned usr_key = #{usrKey} resource oiu_key = #{oiuKey}"


    #for i in (1..10)
        usrIntf.disableAppForUser(usrKey, oiuKey)
        puts "Disabled resource for usr_key = #{usrKey} oiu_key = #{oiuKey}"
    #end

    #oiuKey = 6762

    #usrIntf.enableAppForUser(usrKey, oiuKey)
    #puts "Enabled resource for usr_key = #{usrKey} oiu_key = #{oiuKey}"

    usrIntf.revokeObject(usrKey, oiuKey)
    puts "Revoke resource for usr_key = #{usrKey} oiu_key = #{oiuKey}"

end


xlclient.close
System.exit 0
