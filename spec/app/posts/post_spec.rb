require File.expand_path('../../../spec_helper', __FILE__)
require 'csv'

Wrappers.describe Post do
  Wrappers.context "#new" do
    Wrappers.it "creates a new Post with given title" do
      result = Post.new title: "test post"
      result.title.should_eq "test post"
    end

    Wrappers.it "creates a new Post with given body" do
      result = Post.new body: "this is the body"
      result.body.should_eq "this is the body"
    end

    Wrappers.it "creates a new Post with given autor" do
      result = Post.new author: "Brayan"
      result.author.should_eq "Brayan"
    end

    Wrappers.it "creates a new post given more than one attribute" do
      result = Post.new title: "test post", body: "this is the body", author: "Brayan"
      result.instance_variables.map{ |v| result.send(v.to_s[1..-1]) }.should_eq [0,"this is the body", "test post", "Brayan", nil]
    end

    Wrappers.it "creates a new post given no attributes" do
      result = Post.new
      result.instance_variables.map{ |v| result.send(v.to_s[1..-1]) }.should_eq [0, nil, nil, nil, nil]
    end
  end

  Wrappers.context "#find_all" do
    Wrappers.it "returns empty array when there are no posts" do
      result = Post.find_all
      result.should_eq []
    end
  end

  Wrappers.context "#save" do
    Wrappers.it "saves the post in the file" do
      post = Post.new title: "test post", body: "this is the body", author: "Brayan"
      post.save

      result = Post.find_all
      result.count.should_eq 1
    end

    Wrappers.it "returns an array of Posts" do
      result = Post.find_all
      result[0].class.should_eq Post
    end
  end

  Wrappers.context "#last_id" do
    Wrappers.it "gets the last id" do
      post = Post.new title: "test post", body: "this is the body", author: "Brayan"
      post.save
      Post.next_id.should_eq 3
    end
  end

  Wrappers.context "#find" do
    Wrappers.it "gets the last id" do
      post = Post.new title: "test post", body: "this is the body", author: "Brayan"
      post.save
      Post.find(3).id.should_eq 3
    end
  end

  file ||= Dir.pwd + "/app/posts/posts.csv"
  CSV.open file, "wb" do |csv|
    csv << ["id", "body", "title", "author", "created_at"]
  end
end
