XLClient oimClient = new XLClient('xelsysadm', 'Welcome1')

def itDefName = 'res3type'
def itResName = args[0]
def itInstIntf = oimClient.itInstIntf
def itDefIntf = oimClient.itDefIntf

def itDefKey = Utils.getITResDefKey(itDefIntf, itDefName)
println "ITRes definition key = ${itDefKey}"

def itResMap = [
    'IT Resources Type Definition.Key' : itDefKey.toString(),
    'IT Resources.Name' : itResName,
    'a' : 'foo' + itResName 
]

def itResKey = itInstIntf.createITResourceInstance(itResMap)
println "Created it resource with key = ${itResKey}"

oimClient.close()
System.exit(0)
