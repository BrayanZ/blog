require 'webrick'
include WEBrick

require './servlet/rest_servlet'
Dir[File.dirname(__FILE__) + '/app/**/*.rb'].each {|file| require file }


dir = Dir::pwd
port = 1504

puts "URL: http://#{Socket.gethostname}:#{port}"

s = HTTPServer.new Port: port, DocumentRoot: "./"

s.mount "/assets", HTTPServlet::FileHandler, './app/assets/'
s.mount "/", RestServlet

trap("INT"){ s.shutdown }
s.start
