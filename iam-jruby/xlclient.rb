# OIM API interface

require 'java'

include_class('java.util.HashMap') {|package,name| "J#{name}" }
include_class('java.util.List') {|package,name| "J#{name}" }
include_class('java.util.ArrayList') {|package,name| "J#{name}" }
include_class('java.util.Iterator') {|package,name| "J#{name}" }
include_class('java.util.Properties') {|package,name| "J#{name}" }
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class('java.util.Random') {|package,name| "J#{name}" }
include_class('javax.xml.parsers.DocumentBuilder') {|package,name| "J#{name}"}
include_class('javax.xml.parsers.DocumentBuilderFactory') {|package,name| "J#{name}"}

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
#include_class('Thor.API.Operations.tcRequestOperationsIntf'){|package,name| "OIM#{name}"}
include_class('Thor.API.Operations.tcITResourceDefinitionOperationsIntf'){|package,name| "OIM#{name}"}
include_class('Thor.API.Operations.tcITResourceInstanceOperationsIntf'){|package,name| "OIM#{name}"}
include_class('Thor.API.Operations.tcUserOperationsIntf'){|package,name| "OIM#{name}"}
include_class('Thor.API.Operations.tcHelpOperationsIntf'){|package,name| "OIM#{name}"}
include_class('Thor.API.Operations.tcQueueOperationsIntf'){|package,name| "OIM#{name}"}
include_class('Thor.API.Operations.tcPropertyOperationsIntf'){|package,name| "OIM#{name}"}
include_class 'Thor.API.Operations.DataCollectionOperationsIntf'
include_class('com.thortech.xl.crypto.tcCryptoUtil'){|package,name| "OIM#{name}"}
include_class('com.thortech.xl.crypto.Base64'){|package,name| "OIM#{name}"}
include_class('com.thortech.xl.crypto.tcSignatureMessage'){|package,name| "OIM#{name}"}
include_class 'com.thortech.xl.util.config.ConfigurationClient'

include_class('Thor.API.tcUtilityFactory'){|package,name| "OIM#{name}"}
#include_class 'oracle.iam.platform.ClientPlatform'
#include_class ('oracle.iam.platform.Platform') {|package,name| "IAM#{name}"}
include_class 'oracle.iam.platform.OIMClient'
include_class 'org.springframework.beans.factory.BeanCreationException'
include_class 'oracle.iam.identity.usermgmt.api.UserManager'
include_class 'oracle.iam.identity.orgmgmt.api.OrganizationManager'
include_class 'oracle.iam.identity.rolemgmt.api.RoleManager'
include_class 'oracle.iam.request.api.RequestService'
include_class 'oracle.iam.request.api.UnauthenticatedRequestService'
include_class 'oracle.iam.reconciliation.api.ReconOperationsService'
include_class 'oracle.iam.identity.usermgmt.vo.User'
include_class 'oracle.iam.reconciliation.api.ReconConfigService'
include_class 'oracle.iam.reconciliation.api.EventMgmtService'
include_class 'oracle.iam.scheduler.api.SchedulerService'
include_class 'oracle.iam.accesspolicy.api.AccessPolicyService'
include_class 'oracle.iam.configservice.api.ConfigManager'
include_class 'oracle.iam.provisioning.api.EntitlementService'
include_class 'oracle.iam.provisioning.api.ProvisioningService'
#include_class 'oracle.iam.platform.authopss.api.EntityPublicationService'
#include_class 'oracle.iam.platformservice.api.EntityPublicationService'
#include_class 'oracle.iam.provisioning.api.ApplicationInstanceService'
#include_class 'oracle.iam.request.api.UnauthenticatedSelfService'
#include_class 'oracle.iam.provisioning.api.ProvisioningService'
#include_class 'oracle.iam.provisioning.api.ProvisioningServiceInternal'

class XLAPIClient
    attr_accessor :oimclient, :factory, :jndi
    attr_reader :intfMap

    def initialize
        @intfMap = {
            'usr' => OIMtcUserOperationsIntf.java_class,
            'org' => OIMtcOrganizationOperationsIntf.java_class,
            'grp' => OIMtcGroupOperationsIntf.java_class,
            'prov' => OIMtcProvisioningOperationsIntf.java_class,
            'recon' => OIMtcReconciliationOperationsIntf.java_class,
            #'req' => OIMtcRequestOperationsIntf.java_class,
            'obj' => OIMtcObjectOperationsIntf.java_class,
            'fd' => OIMtcFormDefinitionOperationsIntf.java_class,
            'fi' => OIMtcFormInstanceOperationsIntf.java_class,
            'ap' => OIMtcAccessPolicyOperationsIntf.java_class,
            'usrmgr' => UserManager.java_class,
            'orgmgr' => OrganizationManager.java_class,
            'rolemgr' => RoleManager.java_class,
            'reqsvc' => RequestService.java_class,
            'reconsvc' => ReconOperationsService.java_class,
            'unauthreqsvc' => UnauthenticatedRequestService.java_class,
            'import' => OIMtcImportOperationsIntf.java_class,
            'itdef' => OIMtcITResourceDefinitionOperationsIntf.java_class,
            'itinst' => OIMtcITResourceInstanceOperationsIntf.java_class,
            'reconcfg' => ReconConfigService.java_class,
            'reconevent' => EventMgmtService.java_class,
            'upa' => OIMtcAuditOperationsIntf.java_class,
            'sch' => SchedulerService.java_class,
            'queue' => OIMtcQueueOperationsIntf.java_class,
            'help' => OIMtcHelpOperationsIntf.java_class,
            'apsvc' => AccessPolicyService.java_class,
            'dc' => DataCollectionOperationsIntf.java_class,
            'prop' => OIMtcPropertyOperationsIntf.java_class,
            'cfgmgr' => ConfigManager.java_class,
            'ent' => EntitlementService.java_class,
            #'eps' => EntityPublicationService.java_class,
            #'aisvc' => ApplicationInstanceService.java_class,
            #'unauthselfsvc' => UnauthenticatedSelfService.java_class
            #'provsvc' => ProvisioningService.java_class,
            'provint' => ProvisioningServiceInternal.java_class,
            'lookup' => OIMtcLookupOperationsIntf.java_class
        }
    end

    def defaultLogin
        passwordLogin('xelsysadm', 'Welcome1')
    end

    def passwordLogin(userID, password)
        begin
            puts 'Logging in'

            @jndi = ConfigurationClient.getComplexSettingByPath('Discovery.CoreServer').getAllSettings()

            puts "jndi = #{@jndi}"

            @oimclient = OIMClient.new(@jndi)
            @oimclient.login(userID, password)

            @factory = OIMtcUtilityFactory.new(@jndi, userID, password)
        rescue JException => ex
            puts "Java Exception #{ex.message}"
        end
    end

    def passwordLoginWithDiscovery(userID, password, jndi)
        begin
            puts 'Logging in'
            @jndi = jndi

            @oimclient = OIMClient.new(@jndi)
            @oimclient.login(userID, password)

            @factory = OIMtcUtilityFactory.new(@jndi, userID, password)
        rescue JException => ex
            puts "Java Exception #{ex.message}"
        end
    end

    def adminLogin
        begin
            puts 'Logging in'

            @oimclient = OIMClient.new
            @oimclient.loginAsAdmin
        rescue JException => ex
            puts "Java Exception #{ex.message}"
        end
    end
    
    def signatureLogin(userID)
        begin
            puts 'Logging in'
            signedMsg = OIMtcCryptoUtil.sign(userID, 'PrivateKey')
            user = signedMsg.getSignedObject().getObject().to_s
            #password = serializeSignedMsg(signedMsg)
            #password += 'xlSigned::'
            
            #passwordLogin(user, password) 
            @jndi = ConfigurationClient.getComplexSettingByPath('Discovery.CoreServer').getAllSettings()
            #@oimclient = OIMClient.new(@jndi)
            #@oimclient.signatureLogin(userID)

            @factory = OIMtcUtilityFactory.new(@jndi, userID, password)
        rescue JException => ex
            puts "Java Exception #{ex.message}"
        end
    end

    def serializeSignedMsg(msg)
        tmpB = OIMtcCryptoUtil.getSerializedMessage(msg)
        tmp = OIMBase64.getEncoded(tmpB)
        puts "serialized signed msg = #{msg}"
        tmp
    end

    def logout
        puts 'Logging out'
        #@oimclient.logout
        @factory.close
    end

    def getUtility(which)
        clsName = @intfMap[which]
        @oimclient.getService(clsName)
    end

    def getIntf(which)
        clsName = @intfMap[which]
        puts "class name = #{clsName}"
        #@oimclient.getService(clsName)
        @factory.getUtility(clsName.to_s)
    end
    
    
    def getUtilityUnauth(which)
        clsName = @intfMap[which]
        #oracle.iam.platform.Platform.getService(clsName)
    end

    def printRS(rs)
        begin
            puts "COUNT = #{rs.getRowCount}\n\n"
            cols = rs.getColumnNames

            for col in cols
                puts "#{col}"
            end
            puts "--------------------------------------"

            for i in (0..rs.getRowCount-1)
                rs.goToRow i

                for j in (0..cols.length-1)
                    if not cols[j].index('Row Version')
                        puts "#{cols[j]}\t\t: #{rs.getStringValue(cols[j])}"
                    end
                end

                puts "--------------------------------------"
            end
        rescue JException => ex
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

    def getRandomString(sz)
        alphabets = 'abcdefghijklmnopqrstuvwxyz'
        s = ''
        
        for i in (0..sz)
            te = rand(26)
            s += alphabets[te].chr
        end

        s
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

    def getITResInstKey(itResInstName)
        itinst = getUtility('itinst')
        itMap = HashMap.new({
            'IT Resources.Name' => itResInstName
        })
        rs = itinst.findITResourceInstances(itMap)

        rs.goToRow(0)
        rs.getLongValue('IT Resources.Key')
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

end
