// direct provision object

def oim = new Oim()
def usrIntf = oim.usrIntf
def objIntf = oim.objIntf

def usrLogin = args[0]
def objName = args[1]

def usrKey = Utils.getUserKey(usrIntf, usrLogin)
def objKey = Utils.getObjectKey(objIntf, objName)

def oiuKey = usrIntf.provisionObject(usrKey, objKey)

println "Provisioned object to User key = ${oiuKey}"

oim.close()
System.exit(0)

