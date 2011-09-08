require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

usrLogin = 'AGAIN'
objName = 'Role Request'

xlclient = XLAPIClient.new
xlclient.defaultLogin

usrIntf = xlclient.getUtility('usr')
fiIntf = xlclient.getUtility('fi')

usrKey = xlclient.getUsrKey(usrLogin)
objKey = xlclient.getObjKey(objName)


t1 = System.currentTimeMillis
oiuKey = usrIntf.provisionObject(usrKey, objKey)

# get the objects provisioned to the user
rs = usrIntf.getObjects(usrKey)
obiKey = 0
for i in (0..rs.getRowCount-1)
    rs.goToRow i
    oiuKeyFromRS = rs.getLongValue "Users-Object Instance For User.Key"

    if oiuKeyFromRS == oiuKey
        #orcKey = rs.getLongValue "Process Instance.Key"
        obiKey = rs.getLongValue "Object Instance.Key"
        #puts "Got orcKey = #{orcKey}"

    end
end

# set process form data
udHash = {
    'UD_ROLE_R_O_ROLE_NAME' => 'timepass_group'
}

udMap = HashMap.new(udHash)
fiIntf.setObjectFormData(obiKey, udMap)

t2 = System.currentTimeMillis

delta = t2-t1
puts "Provisioned user with key = #{usrKey} resource oiu_key = #{oiuKey} time = #{delta}"

xlclient.close
System.exit 0
