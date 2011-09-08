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

    def setVars(xlclient, tid, begusr, endusr, grpName)
        @xlclient = xlclient
	@tid = tid
	@begusr = begusr
	@endusr = endusr
	@grpName = grpName
    end

    def run
        puts "Running #{@tid}"
        grpIntf = @xlclient.getUtility('grp')
	grpKey = xlclient.getGrpKey(@grpName)

	for usr_key in (@begusr..@endusr)
	    t1 = System.currentTimeMillis
	    grpIntf.addMemberUser(grpKey, usr_key)
	    t2 = System.currentTimeMillis
	    delta = t2-t1
	    puts "Thread #{@tid} added user = #{usr_key} to group grp_key = #{@grpKey} time = #{delta}"
	end
    end
end

# actual script
begusr = 11
step = 500
numThreads = 20
grpName = 'res2'

xlclient = XLAPIClient.new
xlclient.defaultLogin

threads = []

numThreads.times do |i|
    w = Worker.new
    x = i * step + begusr
    y = x + step
    w.setVars(xlclient, 'Thread' + i.to_s, x, y, grpName)
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
