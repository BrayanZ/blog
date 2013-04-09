require 'erb'
module Controllers
  class PostsController
    def self.index params = {}
      @posts = Post.find_all
      file = File.read(Dir.pwd + "/app/posts/views/index.erb")
      page = ERB.new file, 0, "%<>"
      page.result binding
    end

    def self.new params = {}
      file  = File.read(Dir.pwd + "/app/posts/views/new.erb")
      page = ERB.new file, 0, "%<>"
      page.result binding
    end

    def self.show params = {}
      post_id = params[:id].to_i
      @post = Post.find post_id
      @comments = Comment.find_all post_id: post_id
      file = File.read(Dir.pwd + "/app/posts/views/show.erb")
      page = ERB.new file, 0, "%<>"
      page.result binding
    end

    def self.create params
      Post.new(params).save
      {uri: "/"}
    end
  end
end
