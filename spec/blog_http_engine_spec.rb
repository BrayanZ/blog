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
      @engine = BlogEngine.new(blog)
      Thread.new { @engine.run }

      post1_title, post2_title = 'dummy title1', 'dummy title2'
      expect(get('/')).to match /<h1.*>#{post1_title}<\/h1>.*<h1.*>#{post2_title}<\/h1>/m

      @engine.stop
    end
  end

  def get(url, port = 1504)
    sleep 0.1
    full_url = "http://127.0.0.1:#{port}#{url}"
    Net::HTTP.get(URI(full_url))
  end
end
