require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

sch_key = 102
change_note = 'update_karde'

xlclient = XLAPIClient.new
xlclient.defaultLogin

jndi = Hashtable.new({
    'java.naming.provider.url' => 'jnp://dadvmn0695.us.oracle.com:1099',
    'java.naming.factory.initial' => 'org.jnp.interfaces.NamingContextFactory'
})

#xlclient.remoteLogin('xelsysadm', 'xelsysadm', jndi)

provIntf = xlclient.getUtility('prov')

taskMap = HashMap.new({
    'Process Instance.Task Details.Note' => change_note
})

t1 = System.currentTimeMillis
provIntf.updateTask(sch_key, taskMap)
t2 = System.currentTimeMillis
delta = t2-t1
puts "Updated task with key = #{sch_key} time = #{delta}"

xlclient.close
System.exit 0
