class Post
  attr_reader :body, :title, :created_at, :author

  def initialize attrs = {}
    @body = attrs[:body]
    @title = attrs[:title]
    @author = attrs[:author]
  end
end
