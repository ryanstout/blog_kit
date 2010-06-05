ENV['RAILS_ENV'] = 'test'
ENV['RAILS_ROOT'] ||= File.dirname(__FILE__) + '/../../../..'

require 'test/unit'
require File.expand_path(File.join(ENV['RAILS_ROOT'], 'config/environment.rb'))



# Remove any existing user class
Object.send(:remove_const, :User)

# Stub User
class User < ActiveRecord::Base
end

# Stub authentication

class ApplicationController < ActionController::Base
	def current_user
		@user ||= User.first
	end

	def require_user
		return true
	end

end



def load_schema
  config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
  ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")

  db_adapter = ENV['DB']

  # no db passed, try one of these fine config-free DBs before bombing.
  db_adapter ||=
    begin
      require 'rubygems'
      require 'sqlite'
      'sqlite'
    rescue MissingSourceFile
      begin
        require 'sqlite3'
        'sqlite3'
      rescue MissingSourceFile
      end
    end

  if db_adapter.nil?
    raise "No DB Adapter selected. Pass the DB= option to pick one, or install Sqlite or Sqlite3."
  end

  ActiveRecord::Base.establish_connection(config[db_adapter])
  load(File.dirname(__FILE__) + "/schema.rb")
  # require File.dirname(__FILE__) + '/../rails/init.rb'
end

def setup_user
	@user = User.new(:name => 'Test User', :email => 'test@test.com', :admin => true)
	@user.save(:validate => false)
end

def assert_includes_with_regex(elem, array, message = nil)
	message = build_message message, '<?> is not found in <?>.', elem, array
	assert_block(message) do
		elem.is_a?(String) ? array.include?(elem) : array.grep(elem).size > 0
	end
end
