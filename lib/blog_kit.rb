# BlogKit Setup - handles settings

# require 'tm_syntax_highlighting'
# require 'rubygems'
# require 'uv'
# 
# # takes about a second to this, if we don't do it now, then the first call to highlight will take a little longer
# Uv.init_syntaxes 
# 
# ActionView::Base.send(:include, TmSyntaxHighlighting::Helper)
# ActionController::Base.send(:extend, TmSyntaxHighlighting::Controller)


require 'singleton'
class BlogKit
	include Singleton
	
	def initialize
		load_config
	end
	
	def load_config
		file_name = "#{RAILS_ROOT}/config/blog_kit.yml"
		if File.exists?(file_name)
			begin
				@settings = YAML::load(File.open(file_name).read)
			rescue Exception => e
				puts "blog_kit.yml config file is invalid"
			end
		else
			puts 'No blog_kit.yml config file'
		end
	end
	
	def settings
		@settings
	end
end