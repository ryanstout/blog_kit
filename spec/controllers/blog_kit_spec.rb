# require File.dirname(__FILE__) + '/../spec_helper.rb'
# 
# puts "OID: " + BlogArticlesController.object_id.to_s
# 
# 
# describe BlogArticlesController do
# 
#   before(:each) do
#     @controller = BlogArticlesController.new
#     # @request    = ActionController::TestRequest.new
#     # @response   = ActionController::TestResponse.new
#     # ActionController::Routing::Routes.draw do |map|
#     #   map.blog 'blog'
#     # end
# 
#   end
# 
#   # it "should recognize the blog_articles route" do
#   #   # route_for(:controller => "users", :action => "index").should == "/users"
#   # end
#   
#   it "should load the index page for blog articles" do
#     get :index
#     request.should render({:action => "index"})
#   end
# 
# end