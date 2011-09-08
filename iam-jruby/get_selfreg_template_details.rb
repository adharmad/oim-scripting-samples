require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
include_class 'java.util.HashSet'
include_class 'java.util.ArrayList'

include_class ''

xlclient = XLAPIClient.new
xlclient.defaultLogin

reqSvc = xlclient.getUtility('reqsvc')
 
t1 = System.currentTimeMillis



t = reqSvc.getTemplate('Self-Register User')
    
id = t.getId()
name = t.getTemplateName()
model = t.getModelName()
desc = t.getDescription()
data = t.getTemplateData()

puts "#{id} #{name} #{model} #{desc}"
puts "-------------------"
puts "#{data}"


t2 = System.currentTimeMillis
 
delta = t2-t1

xlclient.logout
System.exit 0
