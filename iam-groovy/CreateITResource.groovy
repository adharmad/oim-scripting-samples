def jndiProps = [
    'java.naming.provider.url' : 't3://adc2120788.us.oracle.com:7001/oim',
    'java.naming.factory.initial' : 'weblogic.jndi.WLInitialContextFactory'
]

XLClient oimClient = new XLClient(new Hashtable(jndiProps), 'xelsysadm', 'Welcome1')
//XLClient oimClient = new XLClient('xelsysadm', 'Welcome1')

def itDefName = 'res1type'
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
