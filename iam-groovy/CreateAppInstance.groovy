import oracle.iam.provisioning.vo.ApplicationInstance

XLClient oimClient = new XLClient('xelsysadm', 'Welcome1')

def aiName = args[0]
def objName = args[1]
def itInstName = args[2]

def aiSvc = oimClient.aiSvc
def itInstIntf = oimClient.itInstIntf
def objIntf = oimClient.objIntf
def rdsSvc = oimClient.rdsSvc

// create the dataset
def ds = Utils.createDataSet(aiName, objName)
rdsSvc.createRequestDataSet(ds)

def ai = new ApplicationInstance(aiName, aiName + ' display', aiName + ' description', Utils.getObjectKey(objIntf, objName), Utils.getITResInstKey(itInstIntf, itInstName), ds.getName(), '')

aiSvc.addApplicationInstance(ai)

println "App instance created name = ${aiName}"

oimClient.close()
System.exit(0)
