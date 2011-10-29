// read property value

def oim = new Oim()
def propIntf = oim.propIntf

def propName = args[0]

def val = propIntf.getPropertyValue(propName)
println "value = ${val}"

oim.close()
System.exit(0)

