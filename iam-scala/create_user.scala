import scala.collection.mutable._
import java.util.HashMap
import java.lang.Long

import com.thortech.xl.util.config.ConfigurationClient
import com.thortech.xl.crypto._
import oracle.iam.platform.OIMClient

import oracle.iam.identity.usermgmt.vo._
import oracle.iam.identity.usermgmt.api._

import OIM._

object CreateUser {
    def main(args: Array[String]) {

        val login: String = args(0)

        // create a user
        val oimClient = getClient("xelsysadm", "Welcome1")
        val usrMgr = getService(oimClient, "usrmgr")

        val usrMap = Map[String,Object](
            "User Login" -> login,
            "First Name" -> (login + "First"),
            "Middle Name" -> (login + "Middle"),
            "Last Name" -> (login + "Last"),
            "usr_password" -> "Welcome1",
            "Role" -> "Full-Time",
            "Xellerate Type" -> "End-User",
            "act_key" -> new Long(1),
            "Common Name" -> login,
            "Email" -> (login + "@oracle.com")
        )

        val u = new User(login, getJavaMap(usrMap))
        val res = usrMgr.create(u)
        val usrKey = res.getEntityId()

        println("User created login = " + login + "  key = " + usrKey)

        oimClient.logout()
    }
}
