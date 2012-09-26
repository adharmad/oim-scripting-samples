from xlclient import *
from user import *

import sys

if __name__ == '__main__':
    numUsers = 100
    prefix = 'killbill'
    xlclient = XLAPIClient('xelsysadm', 'xelsysadm')

    for i in range(numUsers):
        oimUser = OIMUser(xlclient)
        userID = prefix + str(i)
        #print "Creating user " + userID
        oimUser.init(userID)
        oimUser.create()
        
    xlclient.close()
    sys.exit(0)
