require 'post'

describe 'a blog post' do
  let(:post_id)    { 1 }
  let(:post_title) { 'dummy title' }
  let(:post_body)  { "Test body" }
  let(:post)       { Post.new(id: post_id, title: post_title, body: post_body) }

  it 'has a title' do
    expect(post.title).to eq post_title
  end

  it 'has a body' do
    expect(post.body).to eq post_body
  end

  it 'has an id' do
    expect(post.id).to eq post_id
  end

  it 'creates a new post from a YAML file' do
    post = Post.create_from_file Dir.pwd + "/spec/test_post.yml", 4
    expect(post.body).to eq "this is the body with more than one line\n"
    expect(post.title).to eq "dummy title"
    expect(post.id).to eq 4
  end
end
