# When the BlogKit plugin is installed run the blog_assets generator
begin
	if defined?(Rails)
		rails_root = Rails.root
	elsif defined?(RAILS_ROOT)
		rails_root = RAILS_ROOT
	else
		rails_root = File.join(File.dirname(__FILE__), '..', '..', '..')
	end

	if (File.exists?(rails_root) && File.exists?(File.join(rails_root, 'app')))
		require "#{rails_root}/config/boot"
		require "#{rails_root}/config/environment"
		require 'rails/generators'
	end

	begin
		# Run the generator
		Rails::Generators.invoke('blog_assets')

	rescue Exception => e
		puts "The following error ocurred: " + e.inspect
	end
rescue Exception => e
	puts "BlogKit is installed, to continue run:"
	puts "rails generate blog_assets"
end
