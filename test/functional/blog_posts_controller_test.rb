# require File.dirname(__FILE__) + '/../test_helper.rb'
# 
# class BlogPostsControllerTest < ActionController::TestCase
# 	def setup
# 		load_schema
# 		
# 		setup_user
# 	end
# 	
# 	def post_attrs
# 		{
# 			:title => 'Blog Title',
# 			:body => 'Test Body',
# 			:user_id => 1
# 		}
# 	end
# 	
#   test "should get index" do
#     get :index
#     assert_response :success
#     assert_not_nil assigns(:blog_posts)
#   end
# 
#   test "should get new" do
#     get :new
#     assert_response :success
#   end
# 
#   test "should create post" do
#     assert_difference('BlogPost.count') do
#       post :create, :blog_post => post_attrs
#     end
# 
#     assert_redirected_to blog_post_path(assigns(:blog_post))
#   end
# 
#   test "should only let admins create posts" do
# 		@user.admin = false
# 		@user.save
# 		
#     assert_no_difference('BlogPost.count') do
#       post :create, :blog_post => post_attrs
#     end
# 
#     assert_redirected_to blog_posts_path
#   end
# 
#   test "should show post" do
# 		blog_post = BlogPost.create(post_attrs.merge(:user_id => @user.id))
#     get :show, :id => blog_post.to_param
#     assert_response :success
#   end
# 
#   test "should get edit" do
# 		blog_post = BlogPost.create(post_attrs.merge(:user_id => @user.id))
#     get :edit, :id => blog_post.to_param
#     assert_response :success
#   end
# 
#   test "should update post" do
# 		blog_post = BlogPost.create(post_attrs.merge(:user_id => @user.id))
#     put :update, :id => blog_post.to_param, :post => post_attrs
#     assert_redirected_to blog_post_path(assigns(:blog_post))
#   end
# 
# 
#   test "should only let admins update posts" do
# 		@user.admin = false
# 		@user.save
# 		
# 		blog_post = BlogPost.create(post_attrs.merge(:user_id => @user.id))
#     put :update, :id => blog_post.to_param, :post => post_attrs
#     assert_redirected_to blog_posts_path
#   end
# 
#   test "should destroy post" do
# 		blog_post = BlogPost.create(post_attrs.merge(:user_id => @user.id))
#     assert_difference('BlogPost.count', -1) do
#       delete :destroy, :id => blog_post.to_param
#     end
# 
#     assert_redirected_to blog_posts_path
#   end
# end
