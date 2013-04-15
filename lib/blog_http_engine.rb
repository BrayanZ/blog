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
    mount_routes
    trap("INT") { @server.shutdown }
    @server.start
  end

  def mount_routes
    @server.mount "/assets", HTTPServlet::FileHandler, './assets/'
    @server.mount '/', BlogServlet, @blog
    @server.mount '/posts', PostServlet, @blog
  end

  def stop
    @server.shutdown
  end

  class HTTPServlet::AbstractServlet
    def render_view view, variables
      variables.each {|variable, value| instance_variable_set "@#{variable.to_s}", value }
      ERB.new(File.read("views/#{view.to_s}.erb"), 0, "%<>").result binding
    end
  end

  class BlogServlet < HTTPServlet::AbstractServlet
    include WEBrick

    def do_GET request, response
      response.body = render_view(:blog, posts: @options[0].all_posts)
      raise HTTPStatus::OK
    end
  end

  class PostServlet < HTTPServlet::AbstractServlet
    include WEBrick

    def do_GET request, response
      response.body = render_view(:post, post: @options[0].post_by_id(post_id_from_path(request.path)))
      raise HTTPStatus::OK
    end

    def post_id_from_path path
      path.split('/')[2].to_i
    end
  end
end
