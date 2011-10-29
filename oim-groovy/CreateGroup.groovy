// create a group

def grpName = args[0]

def oim = new Oim()
def grpIntf = oim.grpIntf

def map1 = [
    'Groups.Group Name' : grpName
]

def key = grpIntf.createGroup(map1)
println "Group created key = ${key}"

oim.close()
System.exit(0)

