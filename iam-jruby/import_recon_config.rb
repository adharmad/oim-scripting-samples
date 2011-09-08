require 'java'
require 'xlclient'
 
fileName = ARGV[0]

xlclient = XLAPIClient.new
xlclient.defaultLogin
 
rcfgSvc = xlclient.getUtility('reconcfg')

puts "Importing recon config from file #{fileName}"

dbFactory = JDocumentBuilderFactory.newInstance
dbFactory.setNamespaceAware false
builder = dbFactory.newDocumentBuilder
doc = builder.parse fileName
puts "doc = " + doc.to_s
profileName = rcfgSvc.configRecon(doc)

puts "Imported recon config"

xlclient.logout
System.exit 0
