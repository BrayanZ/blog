require File.expand_path('../../../spec_helper', __FILE__)

Wrappers.describe PostsController do
  Wrappers.context "#index" do
    Wrappers.it "loads all the posts" do
      post = PostsController
      post.index
      post.instance_variable_get("@posts".intern).should_eq []
    end
  end
  Wrappers.context "#show" do
    Wrappers.it "finds the post" do
      post = Post.new title: "Test title", body: "test body", author: "Brayan"
      post.save

      post = PostsController
      post.show 1
      post.instance_variable_get("@post".intern).instance_variables.map{ |v| result.send(v.to_s[1..-1]) }.should_eq [1,"test body", "Test title", "Brayan"]
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
    csv << ["id", "body", "title", "created_at", "author"]
  end
end
