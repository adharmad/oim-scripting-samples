from xlclient import *
from user import *

import sys

if __name__ == '__main__':
    userID = 'wbuffet'
    xlclient = XLAPIClient('xelsysadm', 'xelsysadm')
    oimUser = OIMUser(xlclient)
    oimUser.init(userID)
    oimUser.create()
    xlclient.close()
    sys.exit(0)
