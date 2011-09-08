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

    def setVars(xlclient, tid, count)
        @xlclient = xlclient
	    @tid = tid
        @count = count
    end

    def run
        puts "Running #{@tid}"
        usrIntf = @xlclient.getUtility('usr')
        for i in (1..count)
            usrMap = HashMap.new({
                'Users.User ID' => tid + '_' + i.to_s,
                'Users.First Name' => tid + '_' + 'First' + i.to_s,
                'Users.Last Name' => tid + '_' +  'Last' + i.to_s,
                'Users.Middle Name' => tid + '_' +  'Middle' + i.to_s,
                'Users.Password' => 'foo',
                'Users.Role' => 'Full-Time',
                'Users.Xellerate Type' => 'End-User',
                'Organizations.Key' => '1'
            })

            t1 = System.currentTimeMillis
            usrKey = usrIntf.createUser(usrMap)
	        t2 = System.currentTimeMillis

            delta = t2-t1
            puts "Thread #{@tid} created user with key = #{usrKey} time = #{delta}"
        end
    end
end

# actual script
numUsers = 5
numThreads = 5

xlclient = XLAPIClient.new
xlclient.defaultLogin

threads = []

numThreads.times do |i|
	w = Worker.new
    w.setVars(xlclient, 'Thread' + i.to_s, numUsers)
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
