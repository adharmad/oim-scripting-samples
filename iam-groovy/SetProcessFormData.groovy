XLClient oimClient = new XLClient('xelsysadm', 'Welcome1')

def orcKey = args[0]
def parentFormName = args[1]

def fiIntf = oimClient.fiIntf

// set process form data
def itResField = parentFormName + "_ITRES"
def udMap = new HashMap ([
    itResField : new Long(21)
])

fiIntf.setProcessFormData(orcKey.toLong(), (Map)udMap)

oimClient.close()
System.exit(0)
