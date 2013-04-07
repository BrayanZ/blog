require 'erb'
module Controllers
  class PostsController
    def self.index
      @posts = Post.find_all
      file = File.read(Dir.pwd + "/app/posts/views/index.erb")
      page = ERB.new file, 0, "%<>"
      page.result binding
    end

    def self.new
      file  = File.read(Dir.pwd + "/app/posts/views/new.erb")
      page = ERB.new file, 0, "%<>"
      page.result binding
    end

    def self.create params
      Post.new(params).save
      {uri: "/"}
    end
  end
end
