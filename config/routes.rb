ActionController::Routing::Routes.draw do |map|
  map.resources :blog_posts, :collection => {:drafts => :any}, :has_many => :blog_comments

end
