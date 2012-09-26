import scala.collection.mutable._
import java.util.HashMap
import java.lang.Long

import Thor.API.Operations._

import OIM._

object CreateUser {
    def main(args: Array[String]) {

        val login: String = args(0)

        // create a user
        val factory = getFactory("xelsysadm", "xelsysadm")
        val usrIntf = getInterface(factory, "usr").asInstanceOf[tcUserOperationsIntf]

        val map = Map[String,Object](
            "Users.User ID" -> login,
            "Users.First Name" -> (login + "First"),
            "Users.Middle Name" -> (login + "Middle"),
            "Users.Last Name" -> (login + "Last"),
            "Users.Password" -> "foo",
            "Users.Role" -> "Full-Time",
            "Users.Xellerate Type" -> "End-User",
            "Organizations.Key" -> "1",
            "Users.Email" -> (login + "@oracle.com")
        )

        val usrMap = getJavaMap(map)
        val usrKey = usrIntf.createUser(usrMap)

        println("User created login = " + login + "  key = " + usrKey)

        factory.close()
    }
}
