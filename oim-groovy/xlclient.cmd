set GROOVY_HOME=C:\Apps\groovy-1.8.1
set JAVA_HOME=c:\jdk1.6.0_18
set PATH=%JAVA_HOME%\bin;%GROOVY_HOME%\bin;%PATH%

set OIM_HOME=
set OIM_DC_HOME=

set CLASSPATH=%OIM_HOME%\lib\xlAPI.jar;%OIM_HOME%\lib\xlLogger.jar;%OIM_HOME%\lib\xlVO.jar;%OIM_HOME%\lib\xlUtils.jar;%OIM_HOME%\lib\xlCrypto.jar;%OIM_HOME%\lib\xlAuthentication.jar;%OIM_HOME%\lib\xlDataObjectBeans.jar;%OIM_HOME%\ext\log4j-1.2.8.jar;%OIM_DC_HOME%\ext\jbossall-client.jar;%OIM_HOME%\ext\jcert.jar;%OIM_HOME%\ext\jsse.jar;.\ext\jnet.jar;%OIM_HOME%\ext\javagroups-all.jar;%OIM_HOME%\ext\oscache.jar;%OIM_HOME%\ext\commons-logging.jar

set JAVA_OPTS=-DXL.HomeDir=%OIM_HOME% -Djava.security.auth.login.config=%OIM_HOME%/config/auth.conf

%GROOVY_HOME%\bin\groovy %*
