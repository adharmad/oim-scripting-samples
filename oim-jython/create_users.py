from xlclient import *
from user import *

import sys

if __name__ == '__main__':
    numUsers = 10
    prefix = 'jython_user'
    xlclient = XLAPIClient('xelsysadm', 'xelsysadm')

    for i in range(numUsers):
        oimUser = OIMUser(xlclient)
        userID = prefix + str(i)
        print "Creating user " + userID
        oimUser.init(userID)
        oimUser.create()
        
    xlclient.close()
    sys.exit(0)
