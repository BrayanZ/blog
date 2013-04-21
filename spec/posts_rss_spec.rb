require 'posts_rss'

describe 'uses a post rss' do
  let(:blog) { double :blog }

  it 'creates a new posts rss' do
    posts_rss = PostsRSS.new blog
    expect( posts_rss.blog ).to eq blog
  end

  context 'create_posts_feed' do
      let(:post1) { stub(:post, title: "dummy title 1", body: "dummy body 1", id: "1", publicated_at: Time.now, published?:true) }
      let(:post2) { stub(:post, title: "dummy title 2", body: "dummy body 2", id: "2", publicated_at: Time.now, published?:true) }
      let(:blog) { stub(:blog, published_posts: [post1, post2]) }
      let(:posts_rss) { PostsRSS.new(blog) }

    it 'has an author'do
      expect( posts_rss.create_posts_feed.author.name.content ).to eq 'Brayan'
    end

    it 'has the update date'do
      Time.stub(:now).and_return(Time.parse("April 15 1990"))
      expect( posts_rss.create_posts_feed.updated.content ).to eq Time.now
    end

    it 'has about'do
      expect( posts_rss.create_posts_feed.id.content ).to eq 'My own rss feed'
    end

    it 'has title'do
      expect( posts_rss.create_posts_feed.title.content ).to eq 'Blog Feed'
    end

    it "creates the rss' items" do
      expect( posts_rss.create_posts_feed.items.count ).to eq 2
    end
  end
end
