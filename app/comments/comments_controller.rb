module Controllers
  class CommentsController
    def self.create params
      Comment.new(params).save
      {uri: "/posts/show/#{params[:post_id]}"}
    end
  end
end
