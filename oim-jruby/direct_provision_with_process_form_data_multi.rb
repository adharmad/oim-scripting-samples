require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

usrPrefix = 'TEST'
objName = 'GGGGGG'
parentFormName = 'UD_GGGGGG'
childFormName = 'UD_GGGGGG_C'
numUsers = 50

xlclient = XLAPIClient.new
xlclient.defaultLogin

usrIntf = xlclient.getUtility('usr')
fiIntf = xlclient.getUtility('fi')

for idx in (2..numUsers)
    usrLogin = usrPrefix + idx.to_s
    usrKey = xlclient.getUsrKey(usrLogin)
    objKey = xlclient.getObjKey(objName)
    childSdkKey = xlclient.getFormKey(childFormName)

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
        'UD_GGGGGG_ID' => usrLogin,
        'UD_GGGGGG_VAL' => 'ROBO' + idx.to_s
    }

    udMap = HashMap.new(udHash)
    fiIntf.setProcessFormData(orcKey, udMap)

    # child
    for j in (1..3)
        childHash = {
            'UD_GGGGGG_C_CHLD' => usrLogin + "_chld" + j.to_s
        }    
        childMap = HashMap.new(childHash)
    
        fiIntf.addProcessFormChildData(childSdkKey, orcKey, childMap)
    end


    t2 = System.currentTimeMillis

    delta = t2-t1
    puts "Provisioned user with key = #{usrKey} resource oiu_key = #{oiuKey} time = #{delta}"

end

xlclient.close
System.exit 0
