// direct provision object to multple users

def oim = new Oim()
def usrIntf = oim.usrIntf
def objIntf = oim.objIntf

def usrPrefix = args[0]
def startIdx = args[1].toInteger()
def endIdx = args[2].toInteger()
def objName = args[3]

def objKey = Utils.getObjectKey(objIntf, objName)


for (i in startIdx..endIdx) {
    def usrLogin = prefix + i
    def usrKey = Utils.getUserKey(usrIntf, usrLogin)
    def oiuKey = usrIntf.provisionObject(usrKey, objKey)
    println "Provisioned object to User key = ${oiuKey}"
}

oim.close()
System.exit(0)

