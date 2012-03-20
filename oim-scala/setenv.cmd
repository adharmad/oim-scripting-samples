set JAVA_HOME=c:\jdk1.6.0_18
set SCALA_HOME=c:\apps\scala-2.9.1-1
set OIM_HOME=c:\Demo9102\server\xellerate
set OIM_DC_HOME=c:\Demo9102\client\xlclient

set CLASSPATH=.;%OIM_HOME%\lib\xlAPI.jar;%OIM_HOME%\lib\xlLogger.jar;%OIM_HOME%\lib\xlVO.jar;%OIM_HOME%\lib\xlUtils.jar;%OIM_HOME%\lib\xlCrypto.jar;%OIM_HOME%\lib\xlAuthentication.jar;%OIM_HOME%\lib\xlDataObjectBeans.jar;%OIM_HOME%\ext\log4j-1.2.8.jar;%OIM_DC_HOME%\ext\jbossall-client.jar;%OIM_HOME%\ext\javagroups-all.jar;%OIM_HOME%\ext\oscache.jar;%OIM_HOME%\ext\commons-logging.jar

set JAVA_OPTS=-DXL.HomeDir=%OIM_HOME% -Djava.security.auth.login.config=%OIM_HOME%/config/auth.conf
