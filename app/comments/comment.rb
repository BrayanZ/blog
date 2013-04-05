class Comment
  attr_reader :body, :author, :post_id

  def initialize attrs={}
    @body = attrs[:body]
    @author = attrs[:author]
    @post_id = attrs[:post_id]
  end

end
