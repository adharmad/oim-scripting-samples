from java.lang import Thread
from xlclient import *
from recon_event import *
import sys, string, random

if __name__ == '__main__':
    uidPrefix = 'dhoom'
    numEvents = 100
    numUsers = 10

    for i in range(numEvents):
        xlclient = XLAPIClient('xelsysadm', 'xelsysadm')

        for j in range(numUsers):
            uid = uidPrefix + str(i)
            randSuffix = ''.join(random.choice(string.ascii_uppercase) for x in range(4))
            reconEvent = ReconEvent(xlclient, 'mainframe', randSuffix)
            reconEvent.init(uid)
            reconEvent.create()

        xlclient.close()

    sys.exit(0)
