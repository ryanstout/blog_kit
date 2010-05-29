
class BlogPost < ActiveRecord::Base
	include BlogKitModelHelper
	
	unloadable
	
	belongs_to :user
	
	has_many :blog_comments, :dependent => :destroy
	
	validates_presence_of :title
	validates_presence_of :body
	
	if defined?(Rails) && Rails::VERSION::MAJOR >= 3
		scope :published, { :conditions => {:published => true }}
		scope :drafts, { :conditions => {:published => false }}
	else
		named_scope :published, { :conditions => {:published => true }}
		named_scope :drafts, { :conditions => {:published => false }}
	end
	
	before_save :check_published
	
	def check_published
		if self.published_change && self.published_change == [false, true]
			# Moved to published state, update published_on
			self.published_at = Time.now
		end
	end
	
	def show_user?
		(!BlogKit.instance.settings['show_user_who_published'] || BlogKit.instance.settings['show_user_who_published'] == true) && self.user
	end
	
	
	def user_name(skip_link=false)
		if !skip_link && BlogKit.instance.settings['link_to_user']
			link = "<a href=\"/users/#{self.user.id}\">#{self.user.name}</a>"
			return link.html_safe if link.respond_to?(:html_safe)
			return link
		else
			return self.user.name
		end
	end

	def parsed_body
		self.code_highlight_and_markdown(self.body)
	end
	
	def formatted_updated_at
		self.updated_at.strftime(BlogKit.instance.settings['post_date_format'] || '%m/%d/%Y at %I:%M%p')
	end
	
	# Provide SEO Friendly URL's
	def to_param
    "#{id}-#{title.gsub(/[^a-z0-9]+/i, '-')}"
  end
end