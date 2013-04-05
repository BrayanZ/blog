require File.expand_path('../../../spec_helper', __FILE__)

Wrappers.describe Comment do
  Wrappers.context "#new" do
    Wrappers.it "sets the body of the comment" do
      result = Comment.new body: "Test body"
      result.body.should_eq "Test body"
    end

    Wrappers.it "sets the author of the comment" do
      result = Comment.new author: "Test author"
      result.author.should_eq "Test author"
    end

    Wrappers.it "sets the post related to the comment" do
      result = Comment.new post_id: 15
      result.post_id.should_eq 15
    end

    Wrappers.it "creates a new comment given more than one attribute" do
      result = Comment.new post_id: 15, author: "Test commenter", body: "my comment"
      result.instance_variables.map{ |v| result.send(v.to_s[1..-1]) }.should_eq ["my comment", "Test commenter", 15]
    end

    Wrappers.it "creates a new comment given no attributes" do
      result = Comment.new
      result.instance_variables.map{ |v| result.send(v.to_s[1..-1]) }.should_eq [nil, nil, nil]
    end
  end
end
