require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
 
 
xlclient = XLAPIClient.new
xlclient.defaultLogin
 
helpIntf = xlclient.getIntf('help')
 
helpInfo = helpIntf.getHelpAbout()
sortValue = helpIntf.getSortValue()
 
helpInfo.each do |help_key, help_value| 
    puts "#{help_key} ==> #{help_value}"
end

puts "sort value = #{sortValue}"

xlclient.logout
System.exit 0

