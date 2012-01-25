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

    static long getITResDefKey(itDefIntf, itDefName) {
        def itDefKey = 0
		def itDefMap = [
            'IT Resources Type Definition.Server Type' : itDefName
        ]
		def rs = itDefIntf.getITResourceDefinition(itDefMap)
		rs.goToRow(0)
		itDefKey = rs.getLongValue('IT Resources Type Definition.Key')
		return itDefKey
    }

    static void printRS(rs) {
        println "Count = ${rs.getRowCount()}\n"
        def cols = rs.getColumnNames()

        for (i in 0..rs.getRowCount()-1) {
            rs.goToRow(i)

            for (j in 0..cols.length-1) {
                def col = cols[j]
                if (!col.contains('Row Version')) {
                    println "${col}\t\t: ${rs.getStringValue(col)}"
                }
            }

            println "--------------------------------------"

        }
    }
}
