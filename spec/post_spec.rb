require 'post'

describe 'a blog post' do
  let(:post)       { Post.new(id: post_id, title: post_title, body: post_body) }
  let(:post_id)    { 1 }
  let(:post_title) { 'dummy title' }
  let(:post_body)  { "Test body" }

  it 'has a title' do
    expect(post.title).to eq post_title
  end

  it 'has a body' do
    expect(post.body).to eq post_body
  end

  it 'has an id' do
    expect(post.id).to eq post_id
  end
end
