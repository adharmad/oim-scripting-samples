setlocal

set JAVA_HOME=
set JYTHON_HOME=
set OIM_HOME=
set JBOSS_HOME=

set PATH=%JAVA_HOME%\bin;%JYTHON_HOME%\bin;%PATH%

set CLASSPATH=%OIM_HOME%\lib\xlCache.jar;%OIM_HOME%\lib\xlAuthentication.jar;%OIM_HOME%\lib\xlAPI.jar;%OIM_HOME%\lib\xlCrypto.jar;%OIM_HOME%\lib\xlUtils.jar;%OIM_HOME%\lib\xlLogger.jar;%OIM_HOME%\lib\xlDataObjects.jar;%OIM_HOME%\ext\commons-logging.jar;%OIM_HOME%\ext\oscache.jar;%OIM_HOME%\ext\javagroups-all.jar;%OIM_HOME%\ext\log4j-1.2.8.jar;%JBOSS_HOME%\client\jbossall-client.jar;%OIM_HOME%\lib\xlGenConnector.jar;%OIM_HOME%\lib\xlRemoteManager.jar;%OIM_HOME%\lib\xlDDM.jar

%JYTHON_HOME%\jython -DXL.HomeDir=%OIM_HOME% -Djava.security.auth.login.config=%OIM_HOME%\config\auth.conf %* 

endlocal
