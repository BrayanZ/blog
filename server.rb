require 'webrick'
include WEBrick

Dir[File.dirname(__FILE__) + "/config/**/*.rb"].each {|file| require file }
Dir[File.dirname(__FILE__) + '/app/**/*.rb'].each {|file| require file }
require './servlet/rest_servlet'


dir = Dir::pwd
port = 1504

puts "URL: http://#{Socket.gethostname}:#{port}"

s = HTTPServer.new Port: port, DocumentRoot: "./"

s.mount "/assets", HTTPServlet::FileHandler, './app/assets/'
s.mount "/", RestServlet

trap("INT"){ s.shutdown }
s.start
