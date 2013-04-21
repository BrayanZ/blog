require 'post'

describe 'a blog post' do
  let(:post_title) { 'Dummy Title' }
  let(:post_body)  { "Test body" }
  let(:post_publicated_at)  { "12 april 2013 04:12:12 am" }
  let(:post)       { Post.new(title: post_title, body: post_body, publicated_at: post_publicated_at) }

  it 'has a title' do
    expect(post.title).to eq post_title
  end

  it 'has a body' do
    expect(post.body).to eq post_body
  end

  it 'has an id that is the title downcase and spaces swaped for dashes' do
    expect(post.id).to eq "dummy-title"
  end


  it 'creates a new post from a YAML file' do
    post = Post.create_from_file Dir.pwd + "/spec/test_post.yml"
    expect(post.body).to eq "this is the body with more than one line\n"
    expect(post.title).to eq "dummy title"
    expect(post.id).to eq "dummy-title"
    expect(post.publicated_at).to eq DateTime.parse "15 april 2013 03:15:00 pm"
  end

  context 'matches?' do
    it 'search matches with the title' do
      post.stub(:title_includes?).and_return(true)
      expect(post.matches? 'search').to eq true
    end

    it 'search matches with the body' do
      post.stub(:body_includes?).and_return(true)
      expect(post.matches? 'search').to eq true
    end
  end

  context 'rss_item_information' do
    let(:item) { double(:item).as_null_object }

    it 'sets the link of the item' do
      post_link = "/posts/#{post.id}/show"
      item.should_receive(:link=).with(post_link)
      post.rss_item_information(item)
    end

    it 'sets the title of the item' do
      item.should_receive(:title=).with(post.title)
      post.rss_item_information(item)
    end

    it 'sets the updated date of the item' do
      item.should_receive(:updated=).with(post.publicated_at.to_s)
      post.rss_item_information(item)
    end
  end
end
