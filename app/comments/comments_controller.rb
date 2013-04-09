module Controllers
  class CommentsController
    def self.create params
      Comment.new(params).save
      {uri: "/posts/#{params[:post_id]}/show"}
    end
  end
end
