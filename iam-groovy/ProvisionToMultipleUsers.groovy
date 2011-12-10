// direct provision multiple accounts to single user
XLClient oimClient = new XLClient('xelsysadm', 'Welcome1')

def usrPrefix = args[0]
def numUsers = args[1].toInteger()
def objName = args[2]

def usrIntf = oimClient.usrIntf
def objIntf = oimClient.objIntf

def objKey = Utils.getObjectKey(objIntf, objName)

for (i in 1..numInstances) {
    def usrLogin = usrPrefix + i;
    def usrKey = Utils.getUserKey(usrIntf, usrLogin)
    def oiuKey = usrIntf.provisionObject(usrKey, objKey)
    println "Provisioned object ${objName} to User ${usrName}, oiu_key = ${oiuKey}"
}

oimClient.close()
System.exit(0)
