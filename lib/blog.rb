require 'rss'
class Blog
  def initialize *posts
    @posts = posts
  end

  def search_post input
    published_posts.select { |post| post.matches? input }
  end

  def all_posts
    @posts.select { |post| post.published? }
  end

  def published_posts
    @posts.select { |post| post.published? }
  end

  def add_post(post)
    @posts << post
  end

  def post_by_id id
    @posts.find{ |post| post.id == id }
  end

  def published_post_by_id(id)
    published_posts.find { |post| post.id == id }
  end

  def rss
    RSS::Maker.make('atom') do |maker|
      channel_information maker.channel
      add_new_items maker.items
    end
  end

  private
  def add_new_items items
    published_posts.each do |post|
      items.new_item { |item| post.rss_item_information item }
    end
  end

  def channel_information channel
    channel.author = 'Brayan'
    channel.updated = Time.now.to_s
    channel.about = 'My own rss feed'
    channel.title = 'Blog Feed'
  end
end

