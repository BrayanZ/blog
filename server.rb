require 'webrick'

Dir[File.dirname(__FILE__) + '/controllers/**/*.rb'].each {|file| require file }

include WEBrick

dir = Dir::pwd
port = 1504

puts "URL: http://#{Socket.gethostname}:#{port}"

s = HTTPServer.new Port: port

s.mount "/", TopicsIndex

trap("INT"){ s.shutdown }
s.start
