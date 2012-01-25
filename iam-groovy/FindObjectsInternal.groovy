//XLClient oimClient = new XLClient('xelsysadm', 'Welcome1')
XLClient oimClient = new XLClient('dummy1', 'Welcome1')

def provIntSvc = oimClient.provIntSvc

def rs = provIntSvc.invokeLegacyAPI("Thor.API.Operations.tcObjectOperationsIntf", "findObjects", new HashMap())
Utils.printRS(rs)

oimClient.close()
System.exit(0)
