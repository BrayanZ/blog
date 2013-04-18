#!/usr/bin/env ruby

Dir[Dir.pwd + "/lib/*.rb"].each {|lib_file| require lib_file}

class PostFolder
  def initialize posts_path
    @folder = posts_path
  end

  def posts
    Dir[@folder].map { |file| Post.create_from_file(file)}
  end
end

BlogEngine.set :blog, Blog.new(*PostFolder.new(Dir.pwd + "/posts/*.yml").posts)
BlogEngine.run!
