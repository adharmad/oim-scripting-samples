export JAVA_HOME=
export XLHOME=
export CLJ_HOME=
export OIM_SERVER=

$JAVA_HOME/bin/java -DXL.HomeDir=$XLHOME -Djava.security.auth.login.config=$XLHOME/config/authwl.conf clojure.lang.Repl
