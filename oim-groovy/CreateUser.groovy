// Creates a single user whose loginID is passed as a command line
// argument.
// Usage: 
//  xlclient.cmd CreateUser.groovy <USER_ID>

Oim oim = new Oim("xelsysadm")

def usrIntf = oim.usrIntf
def map1 = new HashMap()

def prefix = args[0]

map1['Users.User ID'] = prefix
map1['Users.First Name'] = prefix + "_first"
map1['Users.Last Name'] = prefix + "_last"
map1['Users.Password'] = 'foo'
map1['Users.Role'] = 'Full-Time'
map1['Users.Xellerate Type'] = 'End-User'
map1['Organizations.Key'] = '1'
map1['USR_UDF_REGULAR'] = prefix + '_Regular'
map1['USR_UDF_ENCRYPTED'] = prefix + '_Encrypted'

def key = usrIntf.createUser(map1)

println "User created key = ${key}"

oim.close()
System.exit(0)
