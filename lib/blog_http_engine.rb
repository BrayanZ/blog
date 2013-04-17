require 'net/http'
require 'sinatra/base'

class BlogEngine < Sinatra::Base
  set :views, Proc.new { Dir.pwd + "/views" }
  set :public_folder, Dir.pwd + "/assets/"

  def blog
    @blog ||= settings.blog
  end

  get '/' do
    @posts = blog.all_posts
    erb :blog
  end

  get '/posts/:id/show' do
    @post = blog.published_post_by_id params[:id]
    @post.nil? ? raise(Sinatra::NotFound) : erb(:post)
  end
end
