from xlclient import *
from recon_event import *
import sys

if __name__ == '__main__':
    uid = 'wbuffet'
    xlclient = XLAPIClient('xelsysadm', 'xelsysadm')
    reconEvent = ReconEvent(xlclient, 'mainframe', 'mmm')
    reconEvent.init(uid)
    reconEvent.create()
    xlclient.close()
    sys.exit(0)
