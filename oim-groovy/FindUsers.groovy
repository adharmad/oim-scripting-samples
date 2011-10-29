
Oim oim = new Oim("xelsysadm")

def usrIntf = oim.usrIntf
def map1 = new HashMap()
String[] cols = ['Users.User ID', 'Users.First Name', 'Users.Last Name']


def rs = usrIntf.findUsersFiltered(map1, cols)

for (i in 0..rs.getRowCount()-1) {
    rs.goToRow(i)
    def first = rs.getStringValue("Users.First Name")
    def last = rs.getStringValue("Users.Last Name")
    def uid = rs.getStringValue("Users.User ID")
    println "${uid} -- ${first} :: ${last}"
    
}

oim.close()

System.exit(0)
