XLClient oimClient = new XLClient('xelsysadm', 'Welcome1')

def itInstName = args[0]
def itInstIntf = oimClient.itInstIntf

def itInstKey = Utils.getITResInstKey(itInstIntf, itInstName)

itInstIntf.deleteITResourceInstance(itInstKey)
println "Deleted it resource with key = ${itInstKey}"

oimClient.close()
System.exit(0)
