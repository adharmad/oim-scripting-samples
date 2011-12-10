// direct provision multiple accounts to single user
XLClient oimClient = new XLClient('xelsysadm', 'Welcome1')

def usrLogin = args[0]
def numInstances = args[1].toInteger()
def objName = args[2]

def usrIntf = oimClient.usrIntf
def objIntf = oimClient.objIntf

def objKey = Utils.getObjectKey(objIntf, objName)
def usrKey = Utils.getUserKey(usrIntf, usrLogin)

for (i in 1..numInstances) {
    def oiuKey = usrIntf.provisionObject(usrKey, objKey)
    println "Provisioned object ${objName} to User ${usrLogin}, oiu_key = ${oiuKey}"
}

oimClient.close()
System.exit(0)
