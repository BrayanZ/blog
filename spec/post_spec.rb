require 'post'

describe 'a blog post' do
  let(:post)       { Post.new(title: post_title, body: post_body) }
  let(:post_title) { 'dummy title' }
  let(:post_body)  { "Test body" }

  it 'has a title' do
    expect(post.title).to eq post_title
  end

  it 'has a body' do
    expect(post.body).to eq post_body
  end
end
