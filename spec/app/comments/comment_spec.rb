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
      result.instance_variables.map{ |v| result.send(v.to_s[1..-1]) }.should_eq [0, "my comment", "Test commenter", 15, nil]
    end

    Wrappers.it "creates a new comment given no attributes" do
      result = Comment.new
      result.instance_variables.map{ |v| result.send(v.to_s[1..-1]) }.should_eq [0, nil, nil, 0, nil]
    end
  end

  Wrappers.context "#save" do
    Wrappers.it "saves the comment in the file" do
      comment = Comment.new body: "this is the body", author: "Brayan",post_id: 1
      result =  comment.save
      (!result).should_eq false
    end
    Wrappers.it "saves the comment with the same values" do
      comment = Comment.new body: "this is the body", author: "Brayan",post_id: 1
      result =  comment.save

      result.body.should_eq comment.body
      result.author.should_eq comment.author
      result.post_id.should_eq comment.post_id
      result.created_at.to_date.should_eq Date.today
    end
  end

  Wrappers.context "#find_all" do
    Wrappers.it "finds all the comments" do
      result = Comment.find_all
      result.count.should_eq 2
    end
    Wrappers.it "all the objects found are Comments" do
      result = Comment.find_all
      result.select{|r| r.is_a? Comment }.count.should_eq 2
    end
    Wrappers.it "sets correctly the attributes of the comments" do
      result = Comment.find_all.last

      result.body.should_eq "this is the body"
      result.author.should_eq "Brayan"
      result.post_id.should_eq 1
      result.created_at.to_date.should_eq Date.today
    end
  end

  Wrappers.context "#find" do
    Wrappers.it "gets the comment I'm looking for" do
      comment = Comment.new body: "a new comment", author: "Anonymous",post_id: 2
      comment = comment.save

      result = Comment.find(comment.id)
      result.body.should_eq comment.body
      result.author.should_eq comment.author
      result.post_id.should_eq comment.post_id
    end
  end
end
