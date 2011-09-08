from xlclient import *
from java.util import *
from java.lang import *

import sys

if __name__ == '__main__':
    xlclient = XLAPIClient('xelsysadm', 'xelsysadm')
    usrIntf = xlclient.usrIntf
    
    usrLogin = 't1'
    objName = 'res2'

    usrKey = xlclient.getUsrKey(usrLogin)
    objKey = xlclient.getObjKey(objName)

    print 'usrKey = ', str(usrKey)
    print 'objKey = ', str(objKey)
    oiuKey = usrIntf.provisionObject(usrKey, objKey)
    print 'oiuKey = ', str(oiuKey)

    xlclient.close()
    sys.exit(0)
