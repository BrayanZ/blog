require File.expand_path('../../../spec_helper', __FILE__)

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
      result.instance_variables.map{ |v| result.send(v.to_s[1..-1]) }.should_eq ["this is the body", "test post", "Brayan"]
    end

    Wrappers.it "creates a new post given no attributes" do
      result = Post.new
      result.instance_variables.map{ |v| result.send(v.to_s[1..-1]) }.should_eq [nil, nil, nil]
    end
  end
end
