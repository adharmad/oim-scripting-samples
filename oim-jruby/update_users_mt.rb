require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class('java.lang.Thread') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


class Worker < JThread
    attr_accessor :xlclient, :tid, :count

    def initialize
    end

    def setVars(xlclient, tid, begusr, endusr)
        @xlclient = xlclient
	@tid = tid
	@begusr = begusr
	@endusr = endusr
    end

    def run
        puts "Running #{@tid}"
        usrIntf = @xlclient.getUtility('usr')
	    filter = ['Users.Key', 'Users.User ID', 
	    'Users.Row Version'].to_java(:String)

	    for usr_key in (@begusr..@endusr)
	        usrMap = HashMap.new({
		    'Users.Key' => usr_key.to_s
	        })

	        rs = usrIntf.findUsersFiltered(usrMap, filter)
	        userID = rs.getStringValue('Users.User ID')

	        updateMap = HashMap.new({
		        'Users.First Name' => userID + '555',
		        'Users.Last Name' => userID + '666'
	        })

	        t1 = System.currentTimeMillis
	        usrIntf.updateUser(rs, updateMap)
	        t2 = System.currentTimeMillis
	        delta = t2-t1
	        puts "Thread #{@tid} updated user with key = #{usr_key} time = #{delta}"
	    end
    end
end

# actual script
begusr = 11
step = 500
numThreads = 20

xlclient = XLAPIClient.new
xlclient.defaultLogin

threads = []

numThreads.times do |i|
    w = Worker.new
    x = i * step + begusr
    y = x + step
    w.setVars(xlclient, 'Thread' + i.to_s, x, y)
    threads.push(w)
end

threads.each do |t| 
    puts "Starting #{t.tid}"
    t.start
end

threads.each do |t| 
    puts "Joining #{t.tid}"
    t.join
end

xlclient.close
System.exit 0
