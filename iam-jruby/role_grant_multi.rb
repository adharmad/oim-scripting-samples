require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashSet'


roleKey = '29'
beginUsrKey = 10017
endUsrKey = 20016

xlclient = XLAPIClient.new
xlclient.defaultLogin
 
roleMgr = xlclient.getUtility('rolemgr')

fileName = 'prov2-timing.csv'

File.open(fileName, 'w') do |f|  
    for i in beginUsrKey..endUsrKey
        userSet = HashSet.new
        userSet.add(i.to_s)

        t1 = System.currentTimeMillis
        res = roleMgr.grantRole(roleKey, userSet)
        id = res.getEntityId()
        status = res.getStatus()
        t2 = System.currentTimeMillis
    
        delta = t2-t1
        f.puts "#{i} #{delta}"
    end
end

xlclient.logout 
System.exit 0
