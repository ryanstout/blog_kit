# When the BlogKit plugin is installed run the blog_assets generator
begin
	# First have to load up rails
	unless Kernel.const_defined?('RAILS_ROOT')
		Kernel.const_set('RAILS_ROOT', File.join(File.dirname(__FILE__), '..', '..', '..'))
	end

	if (File.exists?(RAILS_ROOT) && File.exists?(File.join(RAILS_ROOT, 'app')))
		require "#{RAILS_ROOT}/config/boot"
		require "#{RAILS_ROOT}/config/environment"
		require 'rails_generator'
		require 'rails_generator/scripts/generate'
	end
	
	# Run the generator
	Rails::Generator::Scripts::Generate.new.run(['blog_assets'])
	
rescue Exception => e
	puts "The following error ocurred: " + e.inspect
end