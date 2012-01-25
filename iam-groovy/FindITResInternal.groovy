XLClient oimClient = new XLClient('xelsysadm', 'Welcome1')
//XLClient oimClient = new XLClient('dummy2', 'Welcome1')

def provIntSvc = oimClient.provIntSvc

def rs = provIntSvc.invokeLegacyAPI("Thor.API.Operations.tcITResourceInstanceOperationsIntf", "findITResourceInstances", new HashMap())
Utils.printRS(rs)

oimClient.close()
System.exit(0)
