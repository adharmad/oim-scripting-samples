# import a DM xml file after substitution

require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}

template_file = ARGV[0]
subst_str = ARGV[1]
subst_file = subst_str + ".xml"

puts "template file = #{template_file}, subst_file = #{subst_file}"

xlclient = XLAPIClient.new
xlclient.defaultLogin

xlclient.create_subst_file(template_file, subst_file, 'XXXX', subst_str)

impIntf = xlclient.getUtility('imp')
impIntf.acquireLock(true)

subst_file_content = xlclient.read_file(subst_file)

t1 = System.currentTimeMillis
col = impIntf.addXMLFile(subst_file, subst_file_content)
impIntf.performImport(col)
t2 = System.currentTimeMillis

delta = t2-t1
puts "Imported file #{subst_file}"

xlclient.close
System.exit 0
