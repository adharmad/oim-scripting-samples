from xlclient import *
from java.util import *
from java.lang import *

import sys

if __name__ == '__main__':
    xlclient = XLAPIClient('xelsysadm', 'xelsysadm')
    grpIntf = xlclient.grpIntf
    
    grpName = 'res2'
    grpKey = xlclient.getGrpKey(grpName)


    for i in range(4, 10011):
	print 'Adding user = ', str(i), ' to group ', grpName
	grpIntf.addMemberUser(grpKey, i)

    xlclient.close()
    sys.exit(0)
