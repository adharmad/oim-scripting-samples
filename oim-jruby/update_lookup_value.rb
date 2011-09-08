require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


xlclient = XLAPIClient.new
xlclient.defaultLogin

lookupIntf = xlclient.getUtility('lookup')

t1 = System.currentTimeMillis
lookupIntf.updateLookupValue('Lookup.ABC.Test', 'haha', 'haha_new', '123updated', 'en', 'US')
t2 = System.currentTimeMillis

delta = t2-t1
puts "Updatd lookup value"

xlclient.close
System.exit 0
