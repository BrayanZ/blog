require 'net/http'
require 'webrick'
require 'erb'

class BlogEngine
  include WEBrick

  def initialize blog
    @blog = blog
  end

  def run port = 1504
    @server = HTTPServer.new Port: port
    @server.mount '/', BlogServlet, @blog
    @server.mount '/posts', PostServlet, @blog
    trap("INT") { @server.shutdown }
    @server.start
  end

  def stop
    @server.shutdown
  end

  class BlogServlet < HTTPServlet::AbstractServlet
    include WEBrick

    def do_GET request, response
      blog = @options[0]
      @posts = blog.all_posts
      response.body = render(:blog)
      raise HTTPStatus::OK
    end

    def render(view)
      ERB.new(File.read("views/#{view.to_s}.erb"), 0, "%<>").result(binding)
    end
  end

  class PostServlet < HTTPServlet::AbstractServlet
    include WEBrick

    def do_GET request, response
      blog = @options[0]
      path = request.unparsed_uri.split '/'
      @post = blog.post_by_id(path[2].to_i)
      response.body = render(:post)
      raise HTTPStatus::OK
    end

    def render(view)
      ERB.new(File.read("views/#{view.to_s}.erb"), 0, "%<>").result(binding)
    end
  end
end
