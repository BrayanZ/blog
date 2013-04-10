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
        post1, post2 = double(:post1), double(:post2)
        blog = Blog.new(post1, post2)
        expect(blog.all_posts).to have(2).items
      end
    end
  end


  context 'create a post' do
    it 'adds a post to the blog' do
      post = double(:post)
      blog = Blog.new
      blog.add_post post
      expect(blog.all_posts).not_to be_empty
    end
  end

  context 'post_by_id' do
    let(:post) {{ id: 1}}
    blog = Blog.new(post)
    before(:all){
      post.stub(:id).and_return(post[:id])
    }

    it 'returns the post with the id' do
      expect(blog.post_by_id(1)).to eq post
    end

    it "returns false when the post doesn't have a post with the id" do
      expect(blog.post_by_id 2).to be_false

    end
  end
end
