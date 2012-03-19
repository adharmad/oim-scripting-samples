import scala.collection.mutable._
import java.util.HashMap
import java.lang.Long

import Thor.API.Operations._
import com.thortech.xl.util.config.ConfigurationClient
import com.thortech.xl.crypto._
import oracle.iam.platform.OIMClient

import oracle.iam.identity.usermgmt.vo._
import oracle.iam.identity.usermgmt.api._

import OIM._

object ProvisionObject {
    def main(args: Array[String]) {

        val login: String = args(0)
        val objName: String = args(1)

        // create a user
        val factory = getFactory("xelsysadm", "Welcome1")
        val usrIntf: tcUserOperationsIntf = getInterface(factory, "usr").asInstanceOf[tcUserOperationsIntf]
        val objIntf: tcObjectOperationsIntf = getInterface(factory, "obj").asInstanceOf[tcObjectOperationsIntf]

        val usrKey = getUserKey(usrIntf, login)
        val objKey = getObjectKey(objIntf, objName)

        val oiuKey = usrIntf.provisionObject(usrKey, objKey)

        println("Provisioned user " + login + " with object " + objName
            + " oiu_key = " + oiuKey)

        factory.close()
    }
}
