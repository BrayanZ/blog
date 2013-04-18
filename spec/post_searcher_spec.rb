require 'post_searcher'
require 'Blog'

describe 'post searcher' do
  context 'initialize the post searcher' do
    it 'creates a new post searcher' do
      blog = double :blog
      post_searcher = PostSearcher.new blog
      expect( post_searcher.instance_variable_get("@blog") ).to eq blog
    end
  end

  context 'search_post' do

    it 'finds a post given matching in the title' do
      post = stub :post,  title: "A title", body: "dummy body",  published?: true
      post2 = stub :post, title: "another Dummy post", body: "senseless body",  published?: true
      blog = Blog.new post, post2
      post_searcher = PostSearcher.new blog
      expect( post_searcher.search_post "title").to eq [post]
    end

    it 'finds more than one post' do
      post = stub :post,  title: "A title", body: "dummy body",  published?: true
      post2 = stub :post, title: "another Dummy post", body: "senseless body",  published?: true
      blog = Blog.new post, post2
      post_searcher = PostSearcher.new blog
      expect( post_searcher.search_post "dummy").to eq [post, post2]
    end
  end
end
