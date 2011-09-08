from xlclient import *
from group import *

import sys

if __name__ == '__main__':
    groupName = 'coders'
    xlclient = XLAPIClient('xelsysadm', 'xelsysadm')
    oimGroup = OIMGroup(xlclient)
    oimGroup.init(groupName)
    oimGroup.create()
    xlclient.close()
    sys.exit(0)
