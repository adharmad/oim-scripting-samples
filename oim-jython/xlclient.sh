export JAVA_HOME=
export JYTHON_HOME=
export OIM_HOME=
export JBOSS_HOME=

export PATH=$JAVA_HOME/bin:$JYTHON_HOME/bin:$PATH

export CLASSPATH=$OIM_HOME/lib/xlGenConnector.jar:$OIM_HOME/lib/xlRemoteManager.jar:$OIM_HOME/lib/xlDDM.jar:$OIM_HOME/lib/xlCache.jar:$OIM_HOME/lib/xlAuthentication.jar:$OIM_HOME/lib/xlAPI.jar:$OIM_HOME/lib/xlCrypto.jar:$OIM_HOME/lib/xlUtils.jar:$OIM_HOME/lib/xlLogger.jar:$OIM_HOME/lib/xlDataObjects.jar:$OIM_HOME/ext/commons-logging.jar:$OIM_HOME/ext/oscache.jar:$OIM_HOME/ext/javagroups-all.jar:$OIM_HOME/ext/log4j-1.2.8.jar:$JBOSS_HOME/client/jbossall-client.jar

$JYTHON_HOME/jython -DXL.HomeDir=$OIM_HOME -Djava.security.auth.login.config=$OIM_HOME/config/auth.conf $* 

#$JAVA_HOME/bin/java -Dpython.home=$JYTHON_HOME -classpath $JYTHON_HOME/jython.jar:$CLASSPATH org.python.util.jython $*
