require 'java'
require "/home/adharmad/iamapi.jruby/ojdbc5.jar"

include_class 'java.lang.System'

module JavaLang
    include_package "java.lang"
end

module JavaSql
    include_package 'java.sql'
end

dbname = 'adk'
host = 'adc2111036.us.oracle.com'
port = '5525'
login = 'adkadam_adk'
password = 'welcome1'

odriver = Java::JavaClass.for_name("oracle.jdbc.driver.OracleDriver")

#JavaLang::Class.forName('oracle.jdbc.driver.OracleDriver').newInstance

conn = JavaSql::DriverManager.getConnection('jdbc:oracle:thin:@' + host + ':' + port + ':' + dbname, login, password)
stmt = conn.createStatement
rs = stmt.executeQuery("select usr_login from usr")
while (rs.next) do
    id = rs.getString("usr_login")
    puts "#{id}"
end
rs.close
stmt.close
conn.close

System.exit 0
