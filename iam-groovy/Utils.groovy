class Utils {

    static long getObjectKey(objIntf, objName) {
        def objKey = 0
		def objMap = ['Objects.Name' : objName]
		def rs = objIntf.findObjects(objMap)
		rs.goToRow(0)
		objKey = rs.getLongValue('Objects.Key')
		return objKey
    }

    static long getUserKey(usrIntf, usrLogin) {
        def usrKey = 0
		def usrMap = ['Users.User ID' : usrLogin]
		def rs = usrIntf.findUsers(usrMap)
		rs.goToRow(0)
		usrKey = rs.getLongValue('Users.Key')
		return usrKey
    }

    static long getGroupKey(grpIntf, grpName) {
        def grpKey = 0
		def grpMap = ['Groups.Group Name' : grpName]
		def rs = grpIntf.findGroups(grpMap)
		rs.goToRow(0)
		grpKey = rs.getLongValue('Groups.Key')
		return grpKey
    }    
}
