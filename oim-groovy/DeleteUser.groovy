// Deletes the user taking the user ID as a command line argument 
//
// Usage: 
//  xlclient.cmd DeleteUser.groovy <USER_ID>

def oim = new Oim()
def usrIntf = oim.usrIntf

def usrLogin = args[0]
def usrKey = Utils.getUserKey(usrIntf, usrLogin)

usrIntf.deleteUser(usrKey)
println "User deleted key = ${usrKey}"

oim.close()
System.exit(0)

