require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.lang.StringBuffer'
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'
include_class 'java.util.Collection'
include_class 'java.util.Properties'
include_class 'java.io.BufferedReader'
include_class 'java.io.FileReader'

 
fileName = 'XXXX_child.xml'

jndi = Hashtable.new({
    'java.naming.provider.url' => 't3://10.178.92.85:8003/oim',
    'java.naming.factory.initial' => 'weblogic.jndi.WLInitialContextFactory'
})

xlclient = XLAPIClient.new
#xlclient.defaultLogin
xlclient.passwordLogin('xelsysadm', 'Welcome1')
#xlclient.passwordLoginWithDiscovery('xelsysadm', 'Welcome1', jndi)

impIntf = xlclient.getUtility('import')

puts "Acquiring lock"
impIntf.acquireLock(true)

br = BufferedReader.new(FileReader.new(fileName))
sbuf = StringBuffer.new
line = ''

while (line = br.readLine)
    sbuf.append(line)
end

puts "performing import now"

col = impIntf.addXMLFile(fileName, sbuf.to_s)
impIntf.performImport(col)
 
puts "Imported file #{fileName}"

xlclient.logout
 
System.exit 0
