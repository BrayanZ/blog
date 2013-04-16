require 'blog_http_engine'
require 'blog'
require 'post'

describe 'HTTP-based blog engine' do
  describe 'displaying all the blog posts' do
    it 'shows all the blog posts' do
      post1_title, post2_title = 'dummy title1', 'dummy title2'
      post1 = Post.new(title: post1_title)
      post2 = Post.new(title: post2_title)
      blog = Blog.new(post1, post2)
      @engine = BlogEngine.new do {
        set :blog, blog
      }
      t1 = Thread.new { @engine.run! }

      expect(get('/')).to match /<h1.*>#{post1_title}<\/h1>.*<h1.*>#{post2_title}<\/h1>/m

      t1.kill

    end
  end

  describe 'displaying the whole post' do
    it 'shows all the blog content' do
      post_id, post_title, post_body = 2, 'dummy title', 'dummy body'
      post = Post.new id: post_id, title: post_title, body: post_body
      BlogEngine.set :blog, Blog.new(post)
      t1 = Thread.new { BlogEngine.run! }

      expect(get('/posts/2/show')).to match /<h1.*>#{post_title}<\/h1>.*<p>#{post_body}<\/p>/m
      t1.kill
    end
  end

  def get(url, port = 4567)
    sleep 1
    full_url = "http://127.0.0.1:#{port}#{url}"
    Net::HTTP.get(URI(full_url))
  end
end
