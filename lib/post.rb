class Post
  attr_reader :title, :body, :id

  def initialize( title: "", body: '', id: 0)
    @title = title
    @body = body
    @id = id
  end
end
