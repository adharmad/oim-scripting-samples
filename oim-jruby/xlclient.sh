export JAVA_HOME=
export JRUBY_HOME=
export OIM_HOME=
export JBOSS_HOME=
export OC4J_HOME=

export PATH=$JAVA_HOME/bin:$JRUBY_HOME/bin:$PATH

export CLASSPATH=$OIM_HOME/lib/xlCache.jar:$OIM_HOME/lib/xlAuthentication.jar:$OIM_HOME/lib/xlAPI.jar:$OIM_HOME/lib/xlCrypto.jar:$OIM_HOME/lib/xlUtils.jar:$OIM_HOME/lib/xlLogger.jar:$OIM_HOME/lib/xlDataObjects.jar:$OIM_HOME/ext/commons-logging.jar:$OIM_HOME/ext/oscache.jar:$OIM_HOME/ext/javagroups-all.jar:$OIM_HOME/ext/log4j-1.2.8.jar:$JBOSS_HOME/client/jbossall-client.jar:$OC4J_HOME/j2ee/home/oc4jclient.jar:$OC4J_HOME/j2ee/home/lib/ejb.jar

$JRUBY_HOME/bin/jruby -J-DXL.HomeDir=$OIM_HOME -J-Djava.security.auth.login.config=$OIM_HOME/config/auth.conf  $*
