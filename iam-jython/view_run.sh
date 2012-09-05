export JAVA_HOME=
export XLHOME=
export JYTHON_HOME=
export OIM_SERVER=


export CLASSPATH="$OIM_SERVER/ext/internal/eclipselink.jar:$OIM_SERVER/platform/iam-platform-entitymgr.jar:$OIM_SERVER/platform/iam-platform-authz-service.jar:$XLHOME/lib/oimclient.jar:$XLHOME/lib/iam-platform-auth-client.jar:$XLHOME/lib/iam-platform-utils.jar:$XLHOME/lib/iam-platform-context.jar:$XLHOME/lib/iam-platform-pluginframework.jar:$XLHOME/lib/XellerateClient.jar:$XLHOME/lib/XellerateServer.jar:$XLHOME/ext/spring.jar:$XLHOME/ext/security-api.jar:$XLHOME/ext/logging-utils.jar:$XLHOME/ext/jakarta-oro-2.0.8.jar:$XLHOME/ext/bsh.jar:$XLHOME/ext/jhall.jar:$XLHOME/ext/mail.jar:$XLHOME/ext/log4j-1.2.8.jar:$XLHOME/ext/jts.jar:$XLHOME/ext/concurrent.jar:$XLHOME/ext/getopt.jar:$XLHOME/ext/gnu-regexp.jar:$XLHOME/ext/jacorb.jar:$XLHOME/ext/jcert.jar:$XLHOME/ext/jsse.jar:$XLHOME/ext/jnet.jar:$XLHOME/ext/jnp-client.jar:$XLHOME/ext/log4j.jar:$XLHOME/ext/jocache.jar:$XLHOME/lib/xlAPI.jar:$XLHOME/lib/xlLogger.jar:$XLHOME/lib/xlVO.jar:$XLHOME/lib/xlUtils.jar:$XLHOME/lib/xlCrypto.jar:$XLHOME/lib/xlAuthentication.jar:$XLHOME/lib/xlDataObjectBeans.jar:$XLHOME/ext/wlfullclient.jar:$XLHOME/ext/xalan.jar:$XLHOME/ext/xerces.jar:$XLHOME/ext/xercesImpl.jar:$XLHOME/ext/oc4jclient.jar:$XLHOME/ext/ejb.jar:$XLHOME/ext/oscache.jar:$XLHOME/ext/commons-logging.jar:$XLHOME/ext/javagroups-all.jar:$OIM_SERVER/ext/internal/jps-api.jar:$OIM_SERVER/ext/internal/jps/jps-common.jar"

export JAVA_OPTS="-DXL.HomeDir=$XLHOME -Djava.security.auth.login.config=$XLHOME/config/authwl.conf -Dpython.path=$CLASSPATH" 
$JYTHON_HOME/bin/jython $JAVA_OPTS $1
