XLClient oimClient = new XLClient('xelsysadm', 'Welcome1')

def objName = args[0]
def fileName = objName + '.xml'

def expIntf = oimClient.expIntf

def col1 = expIntf.findObjects('Resource', objName)
println col1
println '-------------'
def col2 = expIntf.retrieveChildren(col1)
println col2
println '-------------'

def col3 = col1 + col2
println col3
println '-------------'

def col4 = expIntf.retrieveDependencyTree(col3)
println col4
println '-------------'

def col5 = col3 + col4
println col5
println '-------------'

def col6 = expIntf.arrangeSelectionAsATree(col5)
println col6
println '-------------'


oimClient.close()
System.exit(0)
