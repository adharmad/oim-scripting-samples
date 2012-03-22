require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
 
 
prefix = 'SINGIS'
#special_chars = "&#-*$+/:[]{}?!%@`,"
special_chars = "="
num = 0

xlclient = XLAPIClient.new
xlclient.defaultLogin
#xlclient.passwordLogin('xelsysadm', 'welcome1')
 
usrMgr = xlclient.getUtility('usrmgr')


special_chars.each_byte {|b|
    num += 1
    login = prefix + b.chr.to_s + num.to_s

    puts "Creating user with login = #{login}"
    
    usrHash = {
        'User Login' => login ,
        'First Name' => login + "First",
        'Middle Name' => login + "Middle" ,
        'Last Name' => login + "Last" ,
        'usr_password' => 'password12',
        'Role' => 'Full-Time',
        'Xellerate Type' => 'End-User',
        'act_key' => 1,
        'Common Name' => login
    }
 
    usrMap = HashMap.new(usrHash)
 

    t1 = System.currentTimeMillis
    res = usrMgr.create(usrMap)
    usrKey = res.getEntityId()
    t2 = System.currentTimeMillis
 
    delta = t2-t1
    puts "Created user with key = #{usrKey} time = #{delta}"

}
    
xlclient.logout 
System.exit 0
