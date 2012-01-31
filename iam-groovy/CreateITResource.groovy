def jndiProps = [
    'java.naming.provider.url' : '',
    'java.naming.factory.initial' : ''
]

//XLClient oimClient = new XLClient(new Hashtable(jndiProps), 'xelsysadm', 'Welcome1')
XLClient oimClient = new XLClient('xelsysadm', 'Welcome1')

def itResName = args[0]
def itDefName = args[1]
def itInstIntf = oimClient.itInstIntf
def itDefIntf = oimClient.itDefIntf

def itDefKey = Utils.getITResDefKey(itDefIntf, itDefName)
println "ITRes definition key = ${itDefKey}"

def itResMap = [
    'IT Resources Type Definition.Key' : itDefKey.toString(),
    'IT Resources.Name' : itResName,
    'test1' : 'foo' + itResName,
    'test2' : 'boo' + itResName
]

def itResKey = itInstIntf.createITResourceInstance(itResMap)
println "Created it resource with key = ${itResKey}"

oimClient.close()
System.exit(0)
