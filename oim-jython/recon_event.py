from java.util import *
from java.lang import *
import xlclient
import utils

class ReconEvent:
    def __init__(self, xlclient, objName, suffix, trusted=False):
        self.xlclient = xlclient
        self.objName = objName
        self.suffix = suffix
        self.trusted = trusted
        self.reconIntf = xlclient.reconIntf

    def init(self, uid):
        self.uid = uid

    def create(self):
        t1 = System.currentTimeMillis()
        reconMap = {
            'login' : self.uid,
            'first' : self.uid + '_First_' + self.suffix,
            'last' : self.uid + '_Last_' + self.suffix,
        }

        if self.trusted:
            reconMap.update({
                'role' : 'Full-Time', 
                'xlType' : 'End-User',
                'org' : '1'
            })
        else:
            reconMap.update({
                'itres' : 'mainframe1'
            })

        rceKey = self.reconIntf.createReconciliationEvent(self.objName, utils.map2hm(reconMap), True)
        t2 = System.currentTimeMillis()

        delta = t2-t1
        print 'Created recon event with key = ', str(rceKey), ' time = ', str(delta)
        return rceKey
