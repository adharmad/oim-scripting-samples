#!/usr/bin/ruby

numUsers = ARGV[0]
prefix = ARGV[1]

fileName = prefix + '.csv'

File.open(fileName, 'w') do |f|  
  f.puts "USR_LOGIN, USR_FIRST_NAME, USR_LAST_NAME"

  for i in 1..numUsers.to_i
    login = prefix + i.to_s
    fName = login + 'First'
    lName = login + 'Last'

    f.puts "#{login}, #{fName}, #{lName}"
  end
end
