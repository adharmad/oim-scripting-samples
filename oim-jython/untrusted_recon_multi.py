from xlclient import *
from recon_event import *
import sys

if __name__ == '__main__':
    uid = 'bodyguard'
    numEvents = 100

    xlclient = XLAPIClient('xelsysadm', 'xelsysadm')

    for i in range(numEvents):
        reconEvent = ReconEvent(xlclient, 'mainframe', 'test')
        reconEvent.init(uid)
        reconEvent.create()

    xlclient.close()

    sys.exit(0)
