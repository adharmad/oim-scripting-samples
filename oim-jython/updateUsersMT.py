from xlclient import *
from java.util import *
from java.lang import *

import sys

class T(Thread):
    def __init__(self, xlclient, tid, x, y):
	self.xlclient = xlclient
	self.tid = tid
	self.x = x
	self.y = y

    def __str__(self):
	return self.tid
    
    def run(self):
	usrIntf = self.xlclient.usrIntf
	usrCols = ['Users.Key', 'Users.Row Version', 'Users.User ID']

	usrMap = HashMap()

	for i in range(self.x, self.y):
	    usrMap.put('Users.Key', str(i))

	    rs = usrIntf.findUsersFiltered(usrMap, usrCols)

	    updateMap = HashMap()
	    updateMap.put('Users.First Name', rs.getStringValue('Users.User ID') + 'Fst')
	    updateMap.put('Users.Last Name', rs.getStringValue('Users.User ID') + 'Lst')
	    updateMap.put('USR_UDF_ENCUDF1', 'tt')
	    updateMap.put('USR_UDF_ENCUDF2', 'tt')
	    updateMap.put('USR_UDF_PASSWDUDF', 'tt')

	    t1 = System.currentTimeMillis()
	    usrIntf.updateUser(rs, updateMap)
	    t2 = System.currentTimeMillis()
	    delta = t2-t1
	
	    print 'Updating user ', rs.getStringValue('Users.User ID'), ' time = ', str(delta)
	    
	
if __name__ == '__main__':
    xlclient = XLAPIClient('xelsysadm', 'xelsysadm')
    numThreads = 21
    step = 5000
    threads = []

    for i in range(numThreads):
	x = i * step + 1
	y = x + step
	t = T(xlclient, 'Thread' + str(i), x, y)
	threads.append(t)

    for t in threads:
	print 'Running ', t.tid
	t.start()

    for t in threads:
	print 'Joining ', t.tid
	t.join()

    xlclient.close()
    sys.exit(0)
