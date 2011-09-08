from java.util import *
from java.lang import *
import xlclient
import utils

class OIMGroup:
    def __init__(self, xlclient):
        self.xlclient = xlclient
        self.grpIntf = xlclient.grpIntf

    def init(self, groupName):
        self.groupName = groupName
        self.groupDesc = groupName + '_Description'

    def create(self, timed=False):
        t1 = System.currentTimeMillis()
        usrMap = {
            'Groups.Group Name' : self.groupName,
            'Groups.Group Description' : self.groupDesc
        }

        ugpKey = self.grpIntf.createGroup(utils.map2hm(usrMap))
        t2 = System.currentTimeMillis()

        delta = t2-t1
        print 'Created group with key = ', str(ugpKey)
        return ugpKey
