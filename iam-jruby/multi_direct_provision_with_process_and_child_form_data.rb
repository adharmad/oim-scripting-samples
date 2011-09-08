require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

usrPrefix = 'FOOLISH'
objName = 'XXXX'

parentFormName = 'UD_XXXX'
childForms = ['UD_XXXXCHLD']

xlclient = XLAPIClient.new
xlclient.defaultLogin

usrIntf = xlclient.getUtility('usr')
fiIntf = xlclient.getUtility('fi')

objKey = xlclient.getObjKey(objName)

for idx in (1..100)

    usrLogin = usrPrefix + idx.to_s
    usrKey = xlclient.getUsrKey(usrLogin)

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
        parentFormName + '_SERVER' => '3',
        parentFormName + '_TEST' => usrLogin + '_test_data_hello'
        #parentFormName + '_itres' => '2',
        #parentFormName + '_FIELD2' => usrLogin + '_field2',
        #parentFormName + '_FIELD3' => usrLogin + '_field3',
        #parentFormName + '_FIELD4' => usrLogin + '_field4',
        #parentFormName + '_FIELD5' => usrLogin + '_field5'
    }

    udMap = HashMap.new(udHash)
    fiIntf.setProcessFormData(orcKey, udMap)

    # fill in child form data
    for cForm in childForms
        cFormKey = xlclient.getFormKey(cForm)
       

        for x in 1..5
            udChildMap = HashMap.new({
                cForm + '_VAR1' => usrLogin + '_' + cForm + '_var1',
                cForm + '_VAR2' => usrLogin + '_' + cForm + '_var2',
                cForm + '_VARNUM' => x.to_s
            #    cForm + '_CHILDFIELD1' => usrLogin + '_' + cForm + '_childfield1_value_' + x.to_s,
            #    cForm + '_CHILDFIELD2' => usrLogin + '_' + cForm + '_childfield2_value_' + x.to_s,
            #    cForm + '_CHILDFIELD3' => usrLogin + '_' + cForm + '_childfield3_value_' + x.to_s,
            #    cForm + '_CHILDFIELD4' => usrLogin + '_' + cForm + '_childfield4_value_' + x.to_s,
            #    cForm + '_CHILDFIELD5' => usrLogin + '_' + cForm + '_childfield5_value_' + x.to_s,
            })

            fiIntf.addProcessFormChildData(cFormKey, orcKey, udChildMap)
        end
    end

    t2 = System.currentTimeMillis

    delta = t2-t1
    puts "Provisioned user with login = #{usrLogin} key = #{usrKey} resource oiu_key = #{oiuKey} time = #{delta}"

end

xlclient.logout
System.exit 0
