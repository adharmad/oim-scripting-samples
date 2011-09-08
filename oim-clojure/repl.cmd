set OIM_HOME=

java -DXL.HomeDir=%OIM_HOME% -Djava.security.auth.login.config=%OIM_HOME%\config\auth.conf clojure.main

