require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

usrLogin = ARGV[0]
objName = 'R1'

parentFormName = 'UD_R1'

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
orcKey = 0
for i in (0..rs.getRowCount-1)
    rs.goToRow i
    oiuKeyFromRS = rs.getLongValue "Users-Object Instance For User.Key"

    if oiuKeyFromRS == oiuKey
        orcKey = rs.getLongValue "Process Instance.Key"
        #puts "Got orcKey = #{orcKey}"
    end
end

# set process form data
udHash = {
    parentFormName + '_ITRES' => '5',
    parentFormName + '_LOGIN' => usrLogin
}

udMap = HashMap.new(udHash)
fiIntf.setProcessFormData(orcKey, udMap)

t2 = System.currentTimeMillis

delta = t2-t1
puts "Provisioned user with key = #{usrKey} resource oiu_key = #{oiuKey} time = #{delta}"

xlclient.logout
System.exit 0
