# OIM API interface
require 'java'

include_class('java.util.HashMap') 
include_class('java.util.Iterator') 
include_class('java.util.Properties') 
include_class('java.lang.Exception')
include_class('java.io.BufferedReader')
include_class('java.io.FileReader')
include_class('java.io.FileWriter')
include_class('java.io.BufferedWriter')
include_class('java.io.PrintWriter')

module Java
    include_class('java.lang.String')
end


include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}
include_class('Thor.API.Operations.tcAccessPolicyOperationsIntf'){|package,name| "OIM#{name}"}
include_class('Thor.API.Operations.tcAuditOperationsIntf'){|package,name| "OIM#{name}"}
include_class('Thor.API.Operations.tcFormDefinitionOperationsIntf'){|package,name| "OIM#{name}"}
include_class('Thor.API.Operations.tcFormInstanceOperationsIntf'){|package,name| "OIM#{name}"}
include_class('Thor.API.Operations.tcGroupOperationsIntf'){|package,name| "OIM#{name}"}
include_class('Thor.API.Operations.tcImportOperationsIntf'){|package,name| "OIM#{name}"}
include_class('Thor.API.Operations.tcLookupOperationsIntf'){|package,name| "OIM#{name}"}
include_class('Thor.API.Operations.tcObjectOperationsIntf'){|package,name| "OIM#{name}"}
include_class('Thor.API.Operations.tcOrganizationOperationsIntf'){|package,name| "OIM#{name}"}
include_class('Thor.API.Operations.tcProvisioningOperationsIntf'){|package,name| "OIM#{name}"}
include_class('Thor.API.Operations.tcReconciliationOperationsIntf'){|package,name| "OIM#{name}"}
include_class('Thor.API.Operations.tcRequestOperationsIntf'){|package,name| "OIM#{name}"}
include_class('Thor.API.Operations.tcUserOperationsIntf'){|package,name| "OIM#{name}"}
include_class('Thor.API.Operations.tcITResourceDefinitionOperationsIntf'){|package,name| "OIM#{name}"}
include_class('Thor.API.Operations.tcITResourceInstanceOperationsIntf'){|package,name| "OIM#{name}"}
include_class('Thor.API.Operations.tcPasswordOperationsIntf'){|package,name| "OIM#{name}"}
#include_class('Thor.API.Operations.DataCollectionOperationsIntf'){|package,name| "OIM#{name}"}
include_class('com.thortech.xl.crypto.tcCryptoUtil'){|package,name| "OIM#{name}"}
include_class('com.thortech.xl.crypto.tcSignatureMessage'){|package,name| "OIM#{name}"}
include_class 'com.thortech.xl.util.config.ConfigurationClient'


class XLAPIClient
    attr_accessor :jndi, :factory
    attr_reader :intfMap

    def initialize
        @jndi = ConfigurationClient.getComplexSettingByPath(
            'Discovery.CoreServer').getAllSettings()
        @intfMap = {
            'usr' => 'Thor.API.Operations.tcUserOperationsIntf',
            'org' => 'Thor.API.Operations.tcOrganizationOperationsIntf',
            'grp' => 'Thor.API.Operations.tcGroupOperationsIntf',
            'prov' => 'Thor.API.Operations.tcProvisioningOperationsIntf',
            'recon' => 'Thor.API.Operations.tcReconciliationOperationsIntf',
            'req' => 'Thor.API.Operations.tcRequestOperationsIntf',
            'obj' => 'Thor.API.Operations.tcObjectOperationsIntf',
            'fd' => 'Thor.API.Operations.tcFormDefinitionOperationsIntf',
            'fi' => 'Thor.API.Operations.tcFormInstanceOperationsIntf',
            'ap' => 'Thor.API.Operations.tcAccessPolicyOperationsIntf',
            'imp' => 'Thor.API.Operations.tcImportOperationsIntf',
            'itdef' => 'Thor.API.Operations.tcITResourceDefinitionOperationsIntf',
            'itinst' => 'Thor.API.Operations.tcITResourceInstanceOperationsIntf',
            'lookup' => 'Thor.API.Operations.tcLookupOperationsIntf',
            'dc' => 'Thor.API.Operations.DataCollectionOperationsIntf',
            'pass' => 'Thor.API.Operations.tcPasswordOperationsIntf'
        }
    end

    def defaultLogin
        passwordLogin('xelsysadm', 'xelsysadm')
    end

    def passwordLogin(userID, password)
        begin
            puts 'Logging in'
            puts @jndi.to_s
            @factory = OIMtcUtilityFactory.new(@jndi, userID, password)
        rescue Exception => ex
            puts "Java Exception #{ex.message}"
        end
    end

    def signatureLogin(userID)
        begin
            puts 'Logging in'
            signedMsg = OIMtcCryptoUtil.sign(userID, 'PrivateKey')
		    @factory = OIMtcUtilityFactory.new(@jndi, signedMsg)
        rescue Exception => ex
            puts "Java Exception #{ex.message}"
        end
    end

    def remoteLogin(userID, password, jndi)
        @jndi = jndi
        begin
            puts 'Logging in'
            @factory = OIMtcUtilityFactory.new(@jndi, userID, password)
        rescue Exception => ex
            puts "Java Exception #{ex.message}"
        end
    end

    def close
        puts 'Logging out'
        @factory.close
    end

    def getUtility(which)
        clsName = @intfMap[which]
        @factory.getUtility(clsName)
    end

    def printRS(rs)
        begin
            puts "COUNT = #{rs.getRowCount}\n\n"
            cols = rs.getColumnNames

            for i in (0..rs.getRowCount-1)
                rs.goToRow i

                for j in (0..cols.length-1)
                    if not cols[j].index('Row Version')
                        puts "#{cols[j]}\t\t: #{rs.getStringValue(cols[j])}"
                    end
                end
                puts "------"
            end
        rescue Exception => ex
            puts "Java Exception #{ex.message}"
        end
    end

    def getUsrKey(usrLogin)
	    usrIntf = getUtility('usr')
	    usrMap = HashMap.new({
	        'Users.User ID' => usrLogin
	    })
	    filterCols = ['Users.Key', 'Users.User ID'].to_java(:String)
	    rs = usrIntf.findUsersFiltered(usrMap, filterCols)
	    rs.goToRow(0)
	    rs.getLongValue('Users.Key')
    end

    def getObjKey(objName)
	    objIntf = getUtility('obj')
	    objMap = HashMap.new({
	        'Objects.Name' => objName
    	})
	    rs = objIntf.findObjects(objMap)
	    rs.goToRow(0)
	    rs.getLongValue('Objects.Key')
    end

    def getGrpKey(grpName)
	    grpIntf = getUtility('grp')
	    grpMap = HashMap.new({
	        'Groups.Group Name' => grpName
	    })
	    rs = grpIntf.findGroups(grpMap)
	    rs.goToRow(0)
	    rs.getLongValue('Groups.Key')
    end

    def getITResDefKey(itResDefName)
        itdef = getUtility('itdef')
        itMap = HashMap.new({
            'IT Resources Type Definition.Server Type' => itResDefName
        })
        rs = itdef.getITResourceDefinition(itMap)
        rs.goToRow(0)
        rs.getLongValue('IT Resources Type Definition.Key')
    end

    def getFormKey(formName)
        fdintf = getUtility('fd')
        formMap = HashMap.new({
            'Structure Utility.Table Name' => formName
        })
        rs = fdintf.findForms(formMap)
        rs.goToRow(0)
        rs.getLongValue('Structure Utility.Key')        
    end

    def create_subst_file(template_file, subst_file, temp_str, subst_str)
       begin
            br = BufferedReader.new(FileReader.new(template_file))
            pw = PrintWriter.new(BufferedWriter.new(FileWriter.new(subst_file)))

            while (line = br.readLine())
                jline = Java::String.new(line)
                linesub = jline.replaceAll(temp_str, subst_str)
                pw.println(linesub)
            end

            pw.close()
            br.close()

        rescue Exception => ex
           puts "Java Exception #{ex.message}"
        end        
    end

    def read_file(fileName)
        s = ''
        begin
            br = BufferedReader.new(FileReader.new(fileName))

            while (line = br.readLine())
                s += line
            end

            br.close()
        rescue Exception => ex
            puts "Java Exception #{ex.message}"
        end
        s
    end
end
