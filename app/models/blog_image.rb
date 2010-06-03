class BlogImage < ActiveRecord::Base	
	unloadable
	
	belongs_to :blog_post
	
	attr_accessor :random_id
	
	# Check for paperclip
	if self.respond_to?(:has_attached_file)
		has_attached_file(:image, {
			:styles => {
				:original => '1000x1000>',
				:large    => '600x600>',
				:medium   => '300x300>',
				:small    => '100x100>',
				:thumb    => '30x30>'
			}
		}.merge(BlogKit.instance.settings['paperclip'] || {}))
	end
	
end