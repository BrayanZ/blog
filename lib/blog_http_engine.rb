require 'net/http'
require 'sinatra/base'

class BlogEngine < Sinatra::Base
  set :views, Proc.new { Dir.pwd + "/views" }
  set :public_folder, Dir.pwd + "/assets/"

  def initialize blog
    super
    @blog = blog
  end

  def blog
    @blog ||= settings.blog
  end

  get '/' do
    @posts = blog.all_posts
    erb :blog
  end

  get '/posts/:id/show' do
    @post = blog.post_by_id params[:id].to_i
    erb :post
  end

end
