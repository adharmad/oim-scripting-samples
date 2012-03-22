require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.lang.StringBuffer'
include_class 'java.util.HashMap'
include_class 'java.util.Collection'
include_class 'java.util.Properties'
include_class 'java.io.BufferedReader'
include_class 'java.io.FileReader'

 
 
fileName = 'ross.xml'

xlclient = XLAPIClient.new
xlclient.defaultLogin
 
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
