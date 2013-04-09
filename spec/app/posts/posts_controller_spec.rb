require File.expand_path('../../../spec_helper', __FILE__)

with_clear_files do
  Wrappers.describe PostsController do
    Wrappers.context "#index" do
      Wrappers.it "loads all the posts" do
        PostsController.index
        PostsController.instance_variable_get(:@posts).should_eq []
      end
    end

    Wrappers.context "#show" do
      post = Post.new({title: "Test title", body: "test body", author: "Brayan"}).save
      comment1 = Comment.new({body: "first!! lol", author:"no-lifer", post_id: post.id}).save
      comment2 = Comment.new({body: "Thanks for the post ;)", author:"a friend", post_id: post.id}).save
      PostsController.show id: post.id

      Wrappers.it "finds the post" do
        post_found = PostsController.instance_variable_get(:@post)

        post_found.id.should_eq post.id
        post_found.title.should_eq post.title
        post_found.body.should_eq post.body
        post_found.author.should_eq post.author
        post_found.created_at.mjd.should_eq post.created_at.mjd
      end

      Wrappers.it "finds the comments related to the post" do
        comments = PostsController.instance_variable_get(:@comments)

        comments.count.should_eq 2
        comments.map(&:author).should_eq ["no-lifer", "a friend"]
        comments.map(&:body).should_eq ["first!! lol", "Thanks for the post ;)"]
      end
    end

    Wrappers.context "#create" do
      Wrappers.it "creates a new post" do
        initial_count = Post.find_all.count
        PostsController.create title: "post title", body: "Post body", author: "Brayan"
        Post.find_all.count.should_eq initial_count + 1
      end
      Wrappers.it "saves the post correctly" do
        PostsController.create title: "post title", body: "Post body", author: "Brayan"

        post = Post.find_all.last
        post.id.should_eq 3
        post.title.should_eq "post title"
        post.body.should_eq "Post body"
        post.author.should_eq "Brayan"
        post.created_at.to_date.should_eq Date.today
      end
    end
  end
end
