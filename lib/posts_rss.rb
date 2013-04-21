require 'rss'
class PostsRSS
  attr_accessor :blog

  def initialize(blog, author: 'Brayan', about: 'My own rss feed', title: 'Blog Feed')
    @blog = blog
    @author = author
    @about = about
    @title = title
  end

  def create_posts_feed
    RSS::Maker.make('atom') do |maker|
      channel_information maker.channel
      add_new_items maker.items
    end
  end

  private
  def add_new_items items
    @blog.published_posts.each do |post|
      items.new_item { |item| item_information_from_post item, post }
    end
  end

  def channel_information channel
    channel.author = @author
    channel.updated = Time.now.to_s
    channel.about = @about
    channel.title = @title
  end

  def item_information_from_post item, post
    item.link = "/posts/#{post.id}/show"
    item.title = post.title
    item.updated = post.publicated_at.to_s
  end
end
