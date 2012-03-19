import java.util.{Properties, HashMap}

import scala.collection.mutable._
import scala.collection.JavaConversions._

import Thor.API._
import Thor.API.Operations._
import com.thortech.xl.util.config.ConfigurationClient
import com.thortech.xl.crypto._
//import com.thortech.xl.crypto.tcSignatureMessage

import oracle.iam.identity.usermgmt.api._

import oracle.iam.platform.OIMClient

object OIM {
    val USR_INTF = "Thor.API.Operations.tcUserOperationsIntf"
    val OBJ_INTF = "Thor.API.Operations.tcObjectOperationsIntf"

    def getFactory(login: String, password: String): tcUtilityFactory = {
        println("Logging into OIM")
        val factory = new tcUtilityFactory(jndi(), login, password)
        println("Login successful")
        return factory
    }

    def getClient(login: String, password: String): OIMClient = {
        println("Logging into OIM")
        val client = new OIMClient(jndi())
        client.login(login, password)
        println("Login successful")
        return client
    }

    def jndi(): Properties = ConfigurationClient.getComplexSettingByPath("Discovery.CoreServer").getAllSettings()

    def getService(oimClient: OIMClient, svcClassName: String) = {
        svcClassName match {
            case "usrmgr" => oimClient.getService(classOf[UserManager])
        }
    }

    def getInterface(factory: tcUtilityFactory, intfName: String) = {
        intfName match {
            case "usr" => factory.getUtility(USR_INTF)
            case "obj" => factory.getUtility(OBJ_INTF)
        }
    }
        
    def getJavaMap(map: Map[String, Object]): HashMap[String,Object] = new HashMap(mapAsJavaMap(map))

    def getObjectKey(objIntf: tcObjectOperationsIntf, objName: String): Long = {
        var objKey: Long = 0
        val objMap = Map[String,Object](
            "Objects.Name" -> objName
        )
        val rs = objIntf findObjects getJavaMap(objMap) 
        rs goToRow 0
        objKey = rs getLongValue "Objects.Key"
    
        return objKey
    }

    def getUserKey(usrIntf: tcUserOperationsIntf, usrName: String): Long = {
        var usrKey: Long = 0
        val usrMap = Map[String,Object](
            "Users.User ID" -> usrName
        )
        val rs = usrIntf findUsers getJavaMap(usrMap) 
        rs goToRow 0
        usrKey = rs getLongValue "Users.Key"
    
        return usrKey
    }

}
