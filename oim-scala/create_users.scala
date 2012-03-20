import scala.collection.mutable._
import scala.collection.JavaConversions._
import java.util.HashMap
import java.lang.Long

import Thor.API.Operations._

import OIM._

object CreateUsers {
    def main(args: Array[String]) {

        val prefix: String = args(0)
        val numUsers: Int = args(1).toInt

        val factory = getFactory("xelsysadm", "xelsysadm")
        val usrIntf = getInterface(factory, "usr").asInstanceOf[tcUserOperationsIntf]

        for (i <- 0 until numUsers) {
            val login = prefix + i

            val usrMap = Map[String,Object](
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

        }

        factory.close()
    }
}
