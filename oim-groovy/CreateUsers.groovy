// Creates multiple users 
// Takes the user prefix and the number of users to be created as
// command line arguments. 
//
// Usage: 
//  xlclient.cmd CreateUser.groovy <USER_PREFIX> <NUM_USERS>

Oim oim = new Oim("xelsysadm", "xelsysadm")

def usrIntf = oim.usrIntf

def prefix = args[0]
def numUsers = args[1].toInteger()

def map1 = new HashMap()
map1['Users.First Name'] = 'X'
map1['Users.Last Name'] = 'Z'
map1['Users.Password'] = 'foo'
map1['Users.Role'] = 'Full-Time'
map1['Users.Xellerate Type'] = 'End-User'
map1['Organizations.Key'] = '1'

for (i in 1..numUsers) {
    def login = prefix + i
    map1['Users.User ID'] = login
    def start = System.currentTimeMillis()
    def key = usrIntf.createUser(map1)
    def stop = System.currentTimeMillis()
    println "User created login = ${login} with key = ${key} time = ${stop-start}"
}

oim.close()
System.exit(0)
