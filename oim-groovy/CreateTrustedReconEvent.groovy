Oim oim = new Oim()

def reconIntf = oim.reconIntf
def map1 = new HashMap()

def login = args[0]

map1["login"] = login
map1["first"] = login + '_first'
map1["last"] = login + '_last'
map1["org"] = 'Xellerate Users'
map1["role"] = 'Full-Time'
map1["type"] = 'End-User'

def key = reconIntf.createReconciliationEvent("Xellerate User", map1,
    true)

println "Recon event created key = ${key}"

oim.close()
System.exit(0)
