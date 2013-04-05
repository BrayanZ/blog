require File.expand_path('../../../spec_helper', __FILE__)

Wrappers.describe PostsController do
  Wrappers.context "#index" do
    Wrappers.it "loads all the posts" do
      post = PostsController
      post.index
      post.instance_variable_get("@posts".intern).should_eq []
    end
  end
end
