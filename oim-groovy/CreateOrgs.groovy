// creates multiple organizations

Oim oim = new Oim()

def orgIntf = oim.orgIntf

def prefix = args[0]
def numorgs = args[1].toInteger()

def map1 = new HashMap()
map1["Organizations.Organization Type"] = "Company"

for (i in 1..numorgs) {
    map1['Organizations.Organization Name'] = prefix + i
    println map1

    def key = orgIntf.createOrganization(map1)

    println "Organization created key = ${key}"
}

oim.close()
System.exit(0)
