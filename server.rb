require 'webrick'
include WEBrick

require './servlet/rest_servlet'
Dir[File.dirname(__FILE__) + '/app/**/*_controller.rb'].each {|file| require file }


dir = Dir::pwd
port = 1504

puts "URL: http://#{Socket.gethostname}:#{port}"

s = HTTPServer.new Port: port

s.mount "/", RestServlet

trap("INT"){ s.shutdown }
s.start
