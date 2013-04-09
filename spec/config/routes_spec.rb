require Dir.pwd + "/config/routes"
require File.expand_path('../../spec_helper', __FILE__)
include Medieval

with_clear_files do
  Wrappers.describe Routes do
    def self.route_found response
      "Route found"
    end

    def self.redirect_found response
      "Redirect found"
    end

    def self.route_not_found
      "Route no found"
    end

    Wrappers.context "#match_route" do
      Wrappers.it "finds the route" do
        action = Routes.match_route "/posts", :get
        action.should_eq "PostsController#index"
      end

      Wrappers.it "empty params for route without params" do
        action = Routes.match_route "/posts", :get
        Routes.instance_variable_get(:@params).empty?.should_eq true
      end

      Wrappers.it "doesn't find the route given another method" do
        action = Routes.match_route "/posts", :post
        action.should_eq false
      end

      Wrappers.it "doesn't find a non existing route" do
        action = Routes.match_route "/no/route", :get
        action.should_eq false
      end

      Wrappers.it "finds a route with params" do
        action = Routes.match_route "/posts/5/show", :get
        action.should_eq "PostsController#show"
      end
      Wrappers.it "finds a route with params and get the params" do
        action = Routes.match_route "/posts/5/show", :get
        Routes.instance_variable_get(:@params).should_eq id: "5"
      end
    end

    Wrappers.context "#get" do
      Wrappers.it "calls route found" do
        result = Routes.get "/posts",{}, self
        result.should_eq "Route found"
      end
      Wrappers.it "calls route no found" do
        result = Routes.get "/fake/route",{}, self
        result.should_eq "Route no found"
      end
    end

    Wrappers.context "#post" do
      Wrappers.it "calls route redirect found" do
        result = Routes.post "/posts/create", {}, {}, self
        result.should_eq "Redirect found"
      end
      Wrappers.it "calls route no found" do
        result = Routes.post "/fake/route", {}, {},  self
        result.should_eq "Route no found"
      end
    end
  end
end
