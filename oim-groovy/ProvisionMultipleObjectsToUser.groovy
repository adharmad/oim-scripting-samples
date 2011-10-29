// direct provision multiple objects to user

def oim = new Oim()
def usrIntf = oim.usrIntf
def objIntf = oim.objIntf

def usrLogin = args[0]

def usrKey = Utils.getUserKey(usrIntf, usrLogin)
def objList = ['R1', 'R2', 'R5']

objList.each {
    def objKey = Utils.getObjectKey(objIntf, it)    
    def oiuKey = usrIntf.provisionObject(usrKey, objKey)
    println "Provisioned object ${it} to User. oiu_key = ${oiuKey}"
}

oim.close()
System.exit(0)

