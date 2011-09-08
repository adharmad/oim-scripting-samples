from xlclient import *
from java.util import *
from java.lang import *

import sys

class T(Thread):
    def __init__(self, xlclient, tid, x, y, grpName):
	self.xlclient = xlclient
	self.tid = tid
	self.x = x
	self.y = y
	self.grpName = grpName

    def __str__(self):
	return self.tid
    
    def run(self):
	grpIntf = self.xlclient.grpIntf
	grpKey = self.xlclient.getGrpKey(self.grpName)

	for i in range(self.x, self.y):
	    t1 = System.currentTimeMillis()
	    grpIntf.addMemberUser(grpKey, i)
	    t2 = System.currentTimeMillis()
	    delta = t2-t1
	
	    print 'Added user ', i, ' to group. time = ', str(delta)
	    
	
if __name__ == '__main__':
    xlclient = XLAPIClient('xelsysadm', 'xelsysadm')
    numThreads = 21
    step = 500
    threads = []
    grpName = 'res2'

    for i in range(numThreads):
	x = i * step + 1
	y = x + step
	t = T(xlclient, 'Thread' + str(i), x, y, grpName)
	threads.append(t)

    for t in threads:
	print 'Running ', t.tid
	t.start()

    for t in threads:
	print 'Joining ', t.tid
	t.join()

    xlclient.close()
    sys.exit(0)
