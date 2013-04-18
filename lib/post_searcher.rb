class PostSearcher
  def initialize blog
    @blog = blog
  end

  def search_post search
    @blog.published_posts.select { |post| matches? post, search }
  end

  def matches? post, search
    match_title?(post, search) ||  match_body?(post, search)
  end

  def match_title? post, search
    post.title.downcase.include?(search)
  end

  def match_body? post, search
    post.body.downcase.include?(search)
  end
end
