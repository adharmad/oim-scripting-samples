from java.util import *
from java.lang import *
import xlclient
import utils

class OIMUser:
    def __init__(self, xlclient):
        self.xlclient = xlclient
        self.usrIntf = xlclient.usrIntf

    def init(self, userID):
        self.userID = userID
        self.firstName = userID + 'First'
        self.lastName = userID + 'Last'
        self.orgKey = '1'
        self.role = 'Full-Time'
        self.xlType = 'End-User'
        self.password = 'foo'

    def create(self, timed=False):
        t1 = System.currentTimeMillis()
        usrMap = {
            'Users.User ID' : self.userID,
            'Users.First Name' : self.firstName,
            'Users.Last Name' : self.lastName,
            'Users.Password' : self.password,
            'Users.Role' : self.role,
            'Users.Xellerate Type' : self.xlType,
            'Organizations.Key' : self.orgKey
        }

        usrKey = self.usrIntf.createUser(utils.map2hm(usrMap))
        t2 = System.currentTimeMillis()

        delta = t2-t1
        print 'Created user with login = ', str(self.userID), ' key = ', str(usrKey), ' time = ', str(delta)
        return usrKey
