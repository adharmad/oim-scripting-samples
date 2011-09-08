from xlclient import *
from java.util import *
from java.lang import *

import sys

if __name__ == '__main__':
    xlclient = XLAPIClient('xelsysadm', 'xelsysadm')
    grpIntf = xlclient.grpIntf
    
    usrLogin = 't2'
    grpName = 'res2'

    usrKey = xlclient.getUsrKey(usrLogin)
    grpKey = xlclient.getGrpKey(grpName)

    print 'usrKey = ', str(usrKey)
    print 'grpKey = ', str(grpKey)

    grpIntf.addMemberUser(grpKey, usrKey)

    xlclient.close()
    sys.exit(0)
