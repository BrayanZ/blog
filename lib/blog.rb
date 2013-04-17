class Blog
  def initialize *posts
    @posts = posts
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
end

