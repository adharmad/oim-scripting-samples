from xlclient import *

import sys

if __name__ == '__main__':
    xlclient = XLAPIClient('xelsysadm', 'xelsysadm')
    xlclient.close()
    sys.exit(0)
