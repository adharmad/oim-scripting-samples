// create a org
// Usage:
//  xlclient.cmd CreateOrg.groovy <ORG_NAME>

def oim = new Oim()
def orgIntf = oim.orgIntf

def orgName = args[0]

def map1 = [
    'Organizations.Organization Name' : orgName,
    'Organizations.Type' : 'Company'
]

def key = orgIntf.createOrganization(map1)
println "Organization created key = ${key}"

oim.close()
System.exit(0)

