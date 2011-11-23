Xellerate xel = new Xellerate("xelsysadm")

def usrIntf = xel.usrIntf
def map1 = new HashMap()
String[] cols = ['Users.User ID', 'Users.First Name', 'Users.Last Name']


def rs = usrIntf.findUsersFiltered(map1, cols)

println rs.getClass().getName()

for (i in 0..rs.getRowCount()) {
    rs.goToRow(i)
    println rs.getString("Users.User ID")
    
}

xel.close()

System.exit(0)
