require 'java'
require 'xlclient'
 
include_class 'java.lang.System'
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'

jndi = Hashtable.new({
    'java.naming.provider.url' => 't3://host:port/oim',
    'java.naming.factory.initial' => 'weblogic.jndi.WLInitialContextFactory'
})

xlclient = XLAPIClient.new
#xlclient.defaultLogin
#xlclient.passwordLogin('xelsysadm', 'password')
xlclient.passwordLoginWithDiscovery('xelsysadm', 'password', jndi)

itdef = xlclient.getUtility('itdef')

sc = HashMap.new
rs = itdef.getITResourceDefinition(sc)

#xlclient.printRS(rs)

puts "COUNT = #{rs.getRowCount}\n\n"
#cols = rs.getColumnNames
#cols = ["IT Resources Type Definition.Key", "IT Resources Type Definition.Server Type"]
cols = ["IT Resources Type Definition.Key", "IT Resource Type Definition.Server Type"]

for i in (0..rs.getRowCount-1)
    rs.goToRow i

    for j in (0..cols.length-1)
        puts "#{cols[j]}\t\t: #{rs.getStringValue(cols[j])}"
    end

    puts "--------------------------------------"
end


xlclient.logout
System.exit 0

