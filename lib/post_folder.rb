class PostFolder
  def initialize posts_path
    @folder = posts_path
  end

  def posts
    Dir[@folder].map { |file| PostParser.post_from_file(file)}
  end
end
