export JAVA_HOME=
export XLHOME=
export JYTHON_HOME=
export OIM_SERVER=
export WL_HOME=


CLASSPATH=".:$OIM_SERVER/platform/iam-platform-entitymgr.jar:$OIM_SERVER/platform/iam-platform-authz-service.jar:$XLHOME/lib/oimclient.jar:$OIM_SERVER/lib/iam-platform-auth-client.jar:$OIM_SERVER/lib/iam-platform-utils.jar:$OIM_SERVER/lib/iam-platform-context.jar:$XLHOME/ext/spring.jar:$XLHOME/ext/commons-logging.jar:$XLHOME/ext/log4j-1.2.8.jar:$OIM_SERVER/lib/xlAPI.jar:$OIM_SERVER/lib/xlLogger.jar:$OIM_SERVER/lib/xlVO.jar:$OIM_SERVER/lib/xlUtils.jar:$OIM_SERVER/lib/xlCrypto.jar:$OIM_SERVER/lib/xlAuthentication.jar:$OIM_SERVER/lib/xlDataObjectBeans.jar:$XLHOME/ext/wlfullclient.jar:$OIM_SERVER/ext/commons-logging.jar:$OIM_SERVER/ext/javagroups-all.jar"
export CLASSPATH

export JAVA_OPTS="-DXL.HomeDir=$XLHOME -Djava.security.auth.login.config=$XLHOME/config/authwl.conf -Dpython.path=$CLASSPATH" 
$JYTHON_HOME/bin/jython $JAVA_OPTS $1
