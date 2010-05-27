ENV["RAILS_ENV"] = "test"
require "#{File.expand_path(File.dirname(__FILE__) + "/../../../../")}/config/environment"


Spec::Runner.configure do |config|
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb
  # config.use_transactional_fixtures = true
  # config.use_instantiated_fixtures  = false
end


# ENV["RAILS_ENV"] ||= 'test'
# # RAILS_ROOT='../'
#   
# # begin
#   require 'rubygems'
#   require 'active_support'
#   
#   # Load Rails project
#   # require File.expand_path(File.join(File.dirname(__FILE__), "../../../../config/environment"))
#   require 'spec'
#   require 'spec/autorun'
#   require 'rails'
#   require 'action_view'
#   require 'action_controller'
#   require 'active_record'
#   # require 'spec/rails'
# # rescue LoadError
# #   puts "You need to install rspec"
# #   exit
# # end
# # 
# 
# 
# 
# # ActiveSupport::Dependencies.load_paths << "#{File.dirname(__FILE__)}/../lib"
# # ActiveSupport::Dependencies.load_paths << "#{File.dirname(__FILE__)}/../app/models"
# # ActiveSupport::Dependencies.load_paths << "#{File.dirname(__FILE__)}/../app/controllers"
# 
# 
# class ApplicationController < ActionController::Base
#   helper :all
# end
# 
# $LOAD_PATH.unshift(File.dirname(__FILE__) + '/../app/controllers/')
# $LOAD_PATH.unshift(File.dirname(__FILE__) + '/../app/models/')
# $LOAD_PATH.unshift(File.dirname(__FILE__) + '/../app/views/')
# 
# # ActiveSupport::Dependencies.load_paths.unshift(File.dirname(__FILE__) + '/../app/controllers/')
# # ActiveSupport::Dependencies.load_paths.unshift(File.dirname(__FILE__) + '/../app/models/')
# # ActiveSupport::Dependencies.load_paths.unshift(File.dirname(__FILE__) + '/../app/views/')
# 
# Spec::Runner.configure do |config|
#   # config.use_transactional_fixtures = true
#   # config.use_instantiated_fixtures  = false
# end
# 
# 
# # puts $LOAD_PATH.inspect
# 
# plugin_spec_dir = File.dirname(__FILE__)
# ActiveRecord::Base.logger = Logger.new(plugin_spec_dir + "/debug.log")
