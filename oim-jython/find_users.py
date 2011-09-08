from xlclient import *
from java.util import *

import sys

if __name__ == '__main__':
    xlclient = XLAPIClient('xelsysadm', 'xelsysadm')
    usrIntf = xlclient.usrIntf

    usrMap = HashMap()
    usrMap.put('Users.User ID', 'X*')
    usrMap.put('Users.Role', 'Full-Time')
    usrMap.put('Users.Xellerate Type', 'End-User')

    rs = usrIntf.findUsersFiltered(usrMap, ['Users.Key', 'Users.First Name'])
    xlclient.printRS(rs)

    xlclient.close()
    sys.exit(0)
