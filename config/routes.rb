Rails.application.routes.draw do
	resources :blog_posts do
		resources :blog_comments
		resources :blog_images
		
		collection do
			get :drafts
		end
		
		member do
			get :tag
		end
	end
end