setlocal

set JAVA_HOME=c:\jdk1.6.0_18
set JRUBY_HOME=c:\apps\jruby-1.6.0
set OIM_HOME=
set WEBLOGIC_HOME=
set JBOSS_HOME=

set PATH=%JAVA_HOME%\bin;%JRUBY_HOME%\bin;%PATH%

set CLASSPATH=%OIM_HOME%\lib\xlAPI.jar;%OIM_HOME%\lib\xlDDM.jar;%OIM_HOME%\lib\xlCrypto.jar;%OIM_HOME%\lib\xlUtils.jar;%OIM_HOME%\lib\xlLogger.jar;%OIM_HOME%\lib\xlDataObjects.jar;%OIM_HOME%\lib\xlCache.jar;%OIM_HOME%\lib\xlAuthentication.jar;%OIM_HOME%\ext\commons-logging.jar;%OIM_HOME%\ext\oscache.jar;%OIM_HOME%\ext\javagroups-all.jar;%JBOSS_HOME%\client\jbossall-client.jar;%OIM_HOME%\ext\log4j-1.2.8.jar;%WEBLOGIC_HOME%\wlserver_10.3\server\lib\weblogic.jar

%JRUBY_HOME%\bin\jruby -J-DXL.HomeDir=%OIM_HOME% -J-Djava.security.auth.login.config=%OIM_HOME%\config\auth.conf  %*

endlocal
