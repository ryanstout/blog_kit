if defined?(Rails) && Rails::VERSION::MAJOR >= 3
	# Rails 3
	Rails.application.routes.draw do |map|
		resources :blog_posts do
			resources :blog_comments
			
			collection do
				get :drafts
			end
		end
	end
else
	# Rails 2.x
	ActionController::Routing::Routes.draw do |map|
	  map.resources :blog_posts, :collection => {:drafts => :any}, :has_many => :blog_comments
	end
end