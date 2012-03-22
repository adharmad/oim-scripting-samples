require 'java'
require 'xlclient'
require "./ojdbc5.jar"

module JavaLang
    include_package "java.lang"
end

module JavaSql
    include_package 'java.sql'
end
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
include_class 'java.util.Hashtable'

dbname = 'adk'
host = 'adc2111036.us.oracle.com'
port = '5525'
login = 'adkadam_adk'
password = 'welcome1'

jndi = Hashtable.new({
    'java.naming.provider.url' => 't3://adc2111036.us.oracle.com:7001/oim',
    'java.naming.factory.initial' => 'weblogic.jndi.WLInitialContextFactory'
})

xlclient = XLAPIClient.new
xlclient.passwordLoginWithDiscovery('xelsysadm', 'Welcome1', jndi)
 
grpIntf = xlclient.getUtility('grp')

odriver = Java::JavaClass.for_name("oracle.jdbc.driver.OracleDriver")
#JavaLang::Class.forName('oracle.jdbc.driver.OracleDriver').newInstance

conn = JavaSql::DriverManager.getConnection('jdbc:oracle:thin:@' + host + ':' + port + ':' + dbname, login, password)
stmt = conn.createStatement
rs = stmt.executeQuery("select distinct win_key from win where win_type='javaform' and win_key in (select distinct win_key from uwp)")
while (rs.next) do
    winKey = rs.getString("win_key")
    roleName = xlclient.getRandomString(6)

    grpMap = HashMap.new({
        'Groups.Group Name' => roleName
    })
    grpKey = grpIntf.createGroup(grpMap)
    #puts "winKey = #{winKey}, grpName = #{roleName} , grpKey = #{grpKey}"

    begin
        grpIntf.addForm(grpKey.to_i,winKey.to_i, 1, 0, 0)
    rescue JException => ex
        puts "FAILED winKey = #{winKey}, grpName = #{roleName} , grpKey = #{grpKey}"
        puts "Java Exception #{ex.message}"
    end

end
rs.close
stmt.close
conn.close()        

System.exit 0

