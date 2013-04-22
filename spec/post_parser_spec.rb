require 'post_parser'
require 'post'

describe 'Post parser' do
  it 'creates a new post from a file' do
    post = PostParser.post_from_file('spec/test_post.yml')
    expect( post.class ).to be Post
  end
  it 'sets the title of the post' do
    post = PostParser.post_from_file('spec/test_post.yml')
    post_title = "dummy title"
    expect( post.title ).to eq post_title
  end
  it 'sets the body of the post' do
    post = PostParser.post_from_file('spec/test_post.yml')
    expect( post.body ).to match /<h1.*>this is the body<\/h1>.*with more than one line/m
  end
  it 'sets the publicated at' do
    post = PostParser.post_from_file('spec/test_post.yml')
    expect( post.publicated_at ).to eq DateTime.parse("15 april 2013 03:15:00 pm")
  end
end
