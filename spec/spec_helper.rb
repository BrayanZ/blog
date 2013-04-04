require 'webrick'
Dir[File.dirname(__FILE__) + "/../controllers/**/*.rb"].each do |file|
  puts "spec #{file}"
  require file
end
