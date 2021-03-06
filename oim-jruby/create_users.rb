require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

#numUsers = 1
#prefix = 'asdsdasd'

prefix = ARGV[0]
numUsers = ARGV[1].to_i

puts "prefix = #{prefix}"

xlclient = XLAPIClient.new
xlclient.defaultLogin

#jndi = Hashtable.new({
#    'java.naming.provider.url' => 'jnp://dadvmn0695.us.oracle.com:1099',
#    'java.naming.factory.initial' => 'org.jnp.interfaces.NamingContextFactory'
#})

#xlclient.remoteLogin(jndi, 'xelsysadm', 'xelsysadm')

usrIntf = xlclient.getUtility('usr')

for i in (1..numUsers)
    usrHash = {
        'Users.User ID' => prefix + i.to_s,
        'Users.First Name' => prefix + 'First' + i.to_s,
        'Users.Last Name' => prefix + 'Last' + i.to_s,
        'Users.Middle Name' => prefix + 'Middle' + i.to_s,
        'Users.Password' => 'foo',
        'Users.Role' => 'Full-Time',
        'Users.Xellerate Type' => 'End-User',
        'Organizations.Key' => '1'
    }

    usrMap = HashMap.new(usrHash)

    t1 = System.currentTimeMillis
    usrKey = usrIntf.createUser(usrMap)
    t2 = System.currentTimeMillis

    delta = t2-t1
    puts "Created user with key = #{usrKey} time = #{delta}"
end

xlclient.close
System.exit 0
