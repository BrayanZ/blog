require 'rack/test'
require 'blog_http_engine'
require 'blog'
require 'post'

describe 'HTTP-based blog engine' do
  include Rack::Test::Methods

  def app
    BlogEngine.new
  end

  describe 'displaying all the blog posts' do
    it 'shows all the blog posts' do
      post1_title, post2_title = 'dummy title1', 'dummy title2'
      post1 = stub :post, title: post1_title, published?: true, body: "post 1", id: ""
      post2 = stub :post, title: post2_title, published?: true, body: "post 2", id: ""
      blog = Blog.new(post1, post2)
      BlogEngine.set :blog, blog

      get('/')
      expect(last_response.body).to match /<h1.*>#{post1_title}<\/h1>.*<h1.*>#{post2_title}<\/h1>/m
    end
  end

  describe 'displaying the whole post' do
    it 'shows all the blog content' do
      post_id, post_title, post_body = 'post_id', 'dummy title', 'dummy body'
      post = stub :post, id: post_id, title: post_title, body: post_body, published?: true
      BlogEngine.set :blog, Blog.new(post)

      get('/posts/post_id/show')
      expect(last_response.body).to match /<h1.*>#{post_title}<\/h1>.*<p>#{post_body}<\/p>/m
    end
  end
end
