require 'java'
require 'xlclient'

include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class('java.lang.Thread') {|package,name| "J#{name}" }
include_class 'java.lang.System' 
include_class 'java.util.HashMap'
include_class('Thor.API.tcUtilityFactory') {|package,name| "OIM#{name}"}


class Worker < JThread
    attr_accessor :xlclient, :tid, :count, :login

    def initialize
    end

    def setVars(xlclient, login, tid, count)
        @xlclient = xlclient
        @tid = tid
        @count = count
        @login = login
    end

    def run
        puts "Running #{@tid}"
        usrMgr = @xlclient.getUtility('usrmgr')
        for i in (1..count)
            prefix = login + '_' + tid + '_' + i.to_s

            usrHash = HashMap.new({
                'User Login' => prefix,
                'First Name' => prefix + 'First' ,
                'Middle Name' => prefix + 'Middle' ,
                'Last Name' => prefix + 'Last' ,
                'usr_password' => 'foo',
                'Role' => 'Full-Time',
                'Xellerate Type' => 'End-User',
                'act_key' => 1,
            })
                
            t1 = System.currentTimeMillis
            res = usrMgr.create(usrHash)
            usrKey = res.getEntityId()
            t2 = System.currentTimeMillis

            delta = t2-t1
            puts "Thread #{@tid} created user with key = #{usrKey} time = #{delta}"
        end
    end
end

# actual script
numUsers = 5
numThreads = 5
login = 'yyy'

xlclient = XLAPIClient.new
xlclient.defaultLogin

threads = []

numThreads.times do |i|
    w = Worker.new
    w.setVars(xlclient, login, 'Thread' + i.to_s, numUsers)
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

xlclient.logout
System.exit 0
