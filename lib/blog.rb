class Blog
  def initialize *posts
    @posts = posts
  end

  def all_posts
    @posts.select { |post| post.publicated_at < DateTime.now }
  end

  def add_post(post)
    @posts << post
  end

  def post_by_id id
    @posts.find{ |post| post.id == id }
  end
end
