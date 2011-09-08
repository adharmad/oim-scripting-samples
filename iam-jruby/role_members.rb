require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'


roleKey = '3'
 
xlclient = XLAPIClient.new
xlclient.defaultLogin
 
roleMgr = xlclient.getUtility('rolemgr')

t1 = System.currentTimeMillis
members = roleMgr.getRoleMembers(roleKey)
t2 = System.currentTimeMillis
 
delta = t2-t1
puts "ROle Members = "

members.each { |user|
    entityId = user.getEntityId()
    login = user.getAttribute('User Login')
    first = user.getAttribute('First Name')
    last = user.getAttribute('Last Name')
    puts "#{entityId} : #{login} : #{first} : #{last}"
}

xlclient.logout 
System.exit 0
