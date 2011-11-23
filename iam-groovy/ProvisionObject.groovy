// direct provision resource object to user
XLClient oimClient = new XLClient('xelsysadm', 'Welcome1')

def usrName = args[0]
def objName = args[1]

def usrIntf = oimClient.usrIntf
def objIntf = oimClient.objIntf

def usrKey = Utils.getUserKey(usrIntf, usrName)
def objKey = Utils.getObjectKey(objIntf, objName)

def oiuKey = usrIntf.provisionObject(usrKey, objKey)

println "Provisioned object ${objName} to User ${usrName}, oiu_key = ${oiuKey}"

oimClient.close()
System.exit(0)
