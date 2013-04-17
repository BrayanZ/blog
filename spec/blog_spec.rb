require 'blog'

describe 'A blog' do
  describe 'getting all the blog posts' do
    context 'when there are no posts' do
      it 'returns an empty list' do
        blog = Blog.new
        expect(blog.all_posts).to be_empty
      end
    end

    context 'when ther are posts' do
      it 'returns them' do
        post1, post2 = stub(:post, publicated_at: DateTime.now - 1), stub(:post, publicated_at: DateTime.now - 2)
        blog = Blog.new(post1, post2)
        expect(blog.all_posts).to have(2).items
      end

      it "doesn't include posts with publication Date after today" do
        post1, post2, post_from_future = stub(:post, publicated_at: DateTime.now - 1), stub(:post, publicated_at: DateTime.now - 3), stub(:post, publicated_at: DateTime.now + 1)
        blog = Blog.new(post1, post2, post_from_future)
        expect(blog.all_posts).to eq [post1, post2]
      end
    end
  end


  context 'create a post' do
    it 'adds a post to the blog' do
      post = stub(:post, publicated_at: DateTime.now - 2)
      blog = Blog.new
      blog.add_post post
      expect(blog.all_posts).not_to be_empty
    end
  end

  context 'post_by_id' do
    let(:post_id) { 1 }
    let(:post) { double(:post, id: post_id) }
    let(:blog) { Blog.new post }

    it 'returns the post with the id' do
      expect(blog.post_by_id(post_id)).to eq post
    end

    it "returns false when the post doesn't have a post with the id" do
      non_existing_post_id = 2
      expect(blog.post_by_id non_existing_post_id).to be_false

    end
  end
end
