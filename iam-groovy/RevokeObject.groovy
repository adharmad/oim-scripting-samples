// direct provision resource object to user
XLClient oimClient = new XLClient('xelsysadm', 'Welcome1')

def usrLogin = args[0]
def oiuKey = args[1].toInteger()

def usrIntf = oimClient.usrIntf

def usrKey = Utils.getUserKey(usrIntf, usrLogin)

usrIntf.revokeObject(usrKey, oiuKey)

println "Revoked object from User ${usrLogin}, oiu_key = ${oiuKey}"

oimClient.close()
System.exit(0)
