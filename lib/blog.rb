class Blog
  def initialize *posts
    @posts = posts
  end

  def all_posts
    @posts
  end

  def add_post(post)
    @posts << post
  end
end
