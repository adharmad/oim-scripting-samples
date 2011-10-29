// create a request 

Oim oim = new Oim("xelsysadm")
def reqIntf = oim.reqIntf
def usrIntf = oim.usrIntf
def objIntf = oim.objIntf

def usrLogin = args[0]
def objName = args[1]

def reqMap = ['Requests.Request Priority' : 'High', 
    'Requests.Target Type' : 'U',
    'Requests.Object Request Type' : 'Add'
]

def reqKey = reqIntf.createRequest(reqMap)
println "Request created key = ${reqKey}"

def objKey = Utils.getObjectKey(objIntf, objName)
def usrKey = Utils.getUserKey(usrIntf, usrLogin)

reqIntf.addRequestObject(reqKey, objKey)
reqIntf.addRequestUser(reqKey, usrKey)

reqIntf.completeRequestCreation(reqKey)

println "Request creation complete"

oim.close()
System.exit(0)
