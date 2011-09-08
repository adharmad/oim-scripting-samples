from xlclient import *
from java.util import *
from java.lang import *

import sys

if __name__ == '__main__':
    xlclient = XLAPIClient('xelsysadm', 'xelsysadm')
    usrIntf = xlclient.usrIntf
    usrCols = ['Users.Key', 'Users.Row Version', 'Users.User ID']


    usrMap = HashMap()


    for i in range(4, 110009):	
	usrMap.put('Users.Key', str(i))

	rs = usrIntf.findUsersFiltered(usrMap, usrCols)

	updateMap = HashMap()
	updateMap.put('Users.First Name', rs.getStringValue('Users.User ID') + 'Fst')
	updateMap.put('Users.Last Name', rs.getStringValue('Users.User ID') + 'Fst')
	t1 = System.currentTimeMillis()
	usrIntf.updateUser(rs, updateMap)
	t2 = System.currentTimeMillis()
	delta = t2-t1
	
	print 'Updating user ', rs.getStringValue('Users.User ID'), ' time = ', str(delta)

    xlclient.close()
    sys.exit(0)
