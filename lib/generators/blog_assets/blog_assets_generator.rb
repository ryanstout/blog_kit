require 'rails/generators/migration'  
class BlogAssetsGenerator < Rails::Generators::Base
	include Rails::Generators::Migration
	
	def self.next_migration_number(dirname)
		if ActiveRecord::Base.timestamped_migrations
			@current_time ||= Time.now
			@current_time += 1
			@current_time.utc.strftime("%Y%m%d%H%M%S")
		else
			"%.3d" % (current_migration_number(dirname) + 1)
		end
	end

	
	def self.source_root
		@source_root ||= File.join(File.dirname(__FILE__), 'templates')
	end

	def create_assets
		migration_template 'blog_comments_migration.rb', "db/migrate/create_blog_comments.rb"
		migration_template 'blog_posts_migration.rb', "db/migrate/create_blog_posts.rb"
		migration_template 'blog_tags_migration.rb', "db/migrate/create_blog_tags.rb"
		migration_template 'blog_images_migration.rb', "db/migrate/create_blog_images.rb"
		copy_file "config/blog_kit.yml", "config/blog_kit.yml"
		copy_file "blog_kit.css", "public/stylesheets/blog_kit.css"
				
		# Copy highlighting bundles
		empty_directory "public/stylesheets/syntax"
		copy_file "syntax/active4d.css", "public/stylesheets/syntax/active4d.css"
		copy_file "syntax/all_hallows_eve.css", "public/stylesheets/syntax/all_hallows_eve.css"
		copy_file "syntax/amy.css", "public/stylesheets/syntax/amy.css"
		copy_file "syntax/blackboard.css", "public/stylesheets/syntax/blackboard.css"
		copy_file "syntax/brilliance_black.css", "public/stylesheets/syntax/brilliance_black.css"
		copy_file "syntax/brilliance_dull.css", "public/stylesheets/syntax/brilliance_dull.css"
		copy_file "syntax/cobalt.css", "public/stylesheets/syntax/cobalt.css"
		copy_file "syntax/dawn.css", "public/stylesheets/syntax/dawn.css"
		copy_file "syntax/eiffel.css", "public/stylesheets/syntax/eiffel.css"
		copy_file "syntax/espresso_libre.css", "public/stylesheets/syntax/espresso_libre.css"
		copy_file "syntax/idle.css", "public/stylesheets/syntax/idle.css"
		copy_file "syntax/iplastic.css", "public/stylesheets/syntax/iplastic.css"
		copy_file "syntax/lazy.css", "public/stylesheets/syntax/lazy.css"
		copy_file "syntax/mac_classic.css", "public/stylesheets/syntax/mac_classic.css"
		copy_file "syntax/magicwb_amiga.css", "public/stylesheets/syntax/magicwb_amiga.css"
		copy_file "syntax/pastels_on_dark.css", "public/stylesheets/syntax/pastels_on_dark.css"
		copy_file "syntax/slush_poppies.css", "public/stylesheets/syntax/slush_poppies.css"
		copy_file "syntax/spacecadet.css", "public/stylesheets/syntax/spacecadet.css"
		copy_file "syntax/sunburst.css", "public/stylesheets/syntax/sunburst.css"
		copy_file "syntax/twilight.css", "public/stylesheets/syntax/twilight.css"
		copy_file "syntax/zenburnesque.css", "public/stylesheets/syntax/zenburnesque.css"
	end
end

