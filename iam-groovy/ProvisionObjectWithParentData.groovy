// direct provision resource object to user
XLClient oimClient = new XLClient('xelsysadm', 'Welcome1')

def usrName = args[0]
def objName = args[1]
def parentFormName = args[2]

def usrIntf = oimClient.usrIntf
def objIntf = oimClient.objIntf
def fiIntf = oimClient.fiIntf

def usrKey = Utils.getUserKey(usrIntf, usrName)
def objKey = Utils.getObjectKey(objIntf, objName)

def oiuKey = usrIntf.provisionObject(usrKey, objKey)

println "Provisioned object ${objName} to User ${usrName}, oiu_key = ${oiuKey}"


// get the objects provisioned to the user
def rs = usrIntf.getObjects(usrKey)
def orcKey = 0

for (i in 0..(rs.getRowCount()-1)) {
    rs.goToRow(i)
    def oiuKeyFromRS = rs.getLongValue("Users-Object Instance For User.Key")

    if (oiuKeyFromRS == oiuKey) {
        orcKey = rs.getLongValue("Process Instance.Key")
        println "Got orc_key = ${orcKey}"
    }
}

// set process form data
def itResField = parentFormName + "_ITRES"
def udMap = new HashMap([
    itResField : new Long(21)
])

fiIntf.setProcessFormData(orcKey, (Map)udMap)

oimClient.close()
System.exit(0)
