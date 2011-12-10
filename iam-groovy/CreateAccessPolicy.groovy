
import oracle.iam.identity.rolemgmt.vo.Role

XLClient oimClient = new XLClient('xelsysadm', 'Welcome1')

def polName = 'testpol2'
def roleName = 'role2'
def objName = 'res2'

def apIntf = oimClient.apIntf
def objIntf = oimClient.objIntf
def grpIntf = oimClient.grpIntf

def polMap = [
    'Access Policies.Retrofit Flag' : '1',
	'Access Policies.By Request' : '0',
	'Access Policies.Description' : 'test',
	'Access Policies.Name' : polName,
	'Access Policies.Note' : polName + '_note'
]

def provObjKeys = (long[]) [Utils.getObjectKey(objIntf, objName)]
def revokeObjectsIfNotApply = (boolean[]) [false]
def denyObjKeys = (long[]) []
def groupKeys = (long[]) [Utils.getGroupKey(grpIntf, roleName)]


def polKey = apIntf.createAccessPolicy(polMap, provObjKeys, revokeObjectsIfNotApply, denyObjKeys, groupKeys)
println "Created access policy with name = ${polName} key = ${polKey}"

oimClient.close()
System.exit(0)
