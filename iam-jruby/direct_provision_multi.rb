require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

usrPrefix = 'GRUMPY'
idxBegin = 16
idxEnd = 10015
objName = 'SIMRES'

xlclient = XLAPIClient.new
xlclient.defaultLogin

usrIntf = xlclient.getIntf('usr')
objKey = xlclient.getObjKey(objName)
fileName = usrPrefix + '-timing.csv'

File.open(fileName, 'w') do |f|  

  for i in (idxBegin..idxEnd)
    #usrLogin = usrPrefix + i.to_s
    #usrKey = xlclient.getUsrKey(usrLogin)
    usrKey = i
    
    t1 = System.currentTimeMillis
    oiuKey = usrIntf.provisionObject(usrKey, objKey)
    t2 = System.currentTimeMillis
    
    delta = t2-t1
    #puts "Provisioned user with key = #{usrKey} resource oiu_key = #{oiuKey} time = #{delta}"
    f.puts "#{usrKey} #{delta}"
  end
end

xlclient.logout
System.exit 0
