require File.expand_path('../../../spec_helper', __FILE__)

Wrappers.describe PostsController do
  Wrappers.context "#index" do
    Wrappers.it "loads all the posts" do
      PostsController.index
      PostsController.instance_variable_get(:@posts).should_eq []
    end
  end

  Wrappers.context "#show" do
    Wrappers.it "finds the post" do
      post = Post.new title: "Test title", body: "test body", author: "Brayan"
      post.save

      PostsController.show 1

      post_found = PostsController.instance_variable_get(:@post)
      posts_controlller.index
      post_found.id.should_eq Post.next_id - 1
      post_found.title.should_eq post.title
      post_found.body.should_eq post.body
      post_found.author.should_eq post.author
      post_found.created_at.to_date.should_eq Date.today
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

  file ||= Dir.pwd + "/app/posts/posts.csv"
  CSV.open file, "wb" do |csv|
    csv << ["id", "body", "title", "author", "created_at"]
  end
end
