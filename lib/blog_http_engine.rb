require 'net/http'
require 'sinatra/base'

class BlogEngine < Sinatra::Base
  set :views, Proc.new { Dir.pwd + "/views" }
  set :public_folder, Dir.pwd + "/assets/"

  def blog
    @blog ||= settings.blog
  end

  get '/' do
    @posts = blog.published_posts
    erb :blog
  end

  get '/posts/:id/show' do
    @post = blog.published_post_by_id params[:id]
    @post.nil? ? raise(Sinatra::NotFound) : erb(:post)
  end

  get '/rss' do
    content_type 'text/xml'
    PostsRSS.new(blog).create_posts_feed.to_s
  end

  get '/rss2' do
    content_type 'text/xml'
    blog.rss.to_s
  end

  post '/search' do
    @posts = blog.search_post params[:search]
    erb :search_results
  end
end
