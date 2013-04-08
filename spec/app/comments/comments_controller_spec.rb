require File.expand_path('../../../spec_helper', __FILE__)

with_clear_files do
  Wrappers::describe CommentsController do
    Wrappers::context "#create" do
      controller_result = CommentsController.create body: "This is the body of the comment", author:"Spamer", post_id: "8"
      result = Comment.find_all.last
      Wrappers::it "saves the new comment" do
        result.body.should_eq "This is the body of the comment"
        result.author.should_eq "Spamer"
        result.post_id.should_eq 8
        result.created_at.to_date.should_eq Date.today
      end
      Wrappers::it "redirects to the post page" do
        controller_result[:uri].should_eq "/posts/show/8"
      end
    end
  end
end
