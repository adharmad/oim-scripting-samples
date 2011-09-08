from xlclient import *
from java.util import *
from java.lang import *

import sys

class T(Thread):
    def __init__(self, xlclient, tid, x, y):
	self.xlclient = xlclient
	self.tid = tid

    def __str__(self):
	return self.tid
    
    def run(self):
	usrIntf = self.xlclient.usrIntf
    	usrMap = HashMap()
    	usrMap.put('Users.Key', '100000')

    	rs = usrIntf.findUsersFiltered(usrMap, ['Users.Key', 'Users.User ID'])
    	xlclient.printRS(rs)
	
if __name__ == '__main__':
    xlclient = XLAPIClient('xelsysadm', 'xelsysadm')
    numThreads = 5
    step = 2
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

