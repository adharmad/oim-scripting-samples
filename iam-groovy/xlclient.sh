export JAVA_HOME=/scratch/adharmad/jdk1.6.0_20
export XLHOME=/ade/adharmad_upg1/oracle/work/OIMDesignConsole
export GROOVY_HOME=/scratch/adharmad/devtools/groovy-1.8.4
export OIM_SERVER=/ade/adharmad_upg1/oracle/work/OIM
export WL_HOME=/ade/adharmad_upg1/tklocal/middleware
export APPSERVER_TYPE=wls


CLASSPATH=".:$OIM_SERVER/platform/iam-platform-entitymgr.jar:$OIM_SERVER/platform/iam-platform-authz-service.jar:$XLHOME/lib/oimclient.jar:$OIM_SERVER/lib/iam-platform-auth-client.jar:$OIM_SERVER/lib/iam-platform-utils.jar:$OIM_SERVER/lib/iam-platform-context.jar:$XLHOME/ext/spring.jar:$XLHOME/ext/commons-logging.jar:$XLHOME/ext/log4j-1.2.8.jar:$OIM_SERVER/lib/xlAPI.jar:$OIM_SERVER/lib/xlLogger.jar:$OIM_SERVER/lib/xlVO.jar:$OIM_SERVER/lib/xlUtils.jar:$OIM_SERVER/lib/xlCrypto.jar:$OIM_SERVER/lib/xlAuthentication.jar:$OIM_SERVER/lib/xlDataObjectBeans.jar:$OIM_SERVER/ext/commons-logging.jar:$OIM_SERVER/ext/javagroups-all.jar:$WL_HOME/wlserver_10.3/server/lib/wlclient.jar:$WL_HOME/oracle_common/modules/oracle.jrf_11.1.1/jrf-api.jar"

export CLASSPATH

export JAVA_OPTS="-DXL.HomeDir=$XLHOME -Djava.security.auth.login.config=$XLHOME/config/authwl.conf"
$GROOVY_HOME/bin/groovy $*
