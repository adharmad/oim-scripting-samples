// create multiple groups

def grpPrefix = args[0]
def numGroups = args[1].toInteger()

def oim = new Oim()
def grpIntf = oim.grpIntf

def map1 = new HashMap()

for (i in 1..numGroups) {
    map1['Groups.Group Name'] = grpPrefix + i
    def key = grpIntf.createGroup(map1)

    println "Group created key = ${key}"
}

oim.close()
System.exit(0)
