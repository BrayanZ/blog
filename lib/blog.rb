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

  def post_by_id id
    @posts.each do |post|
      return post if post.id == id
    end
    return false
  end
end
