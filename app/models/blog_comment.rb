class BlogComment < ActiveRecord::Base
	include BlogKitModelHelper
	
	unloadable
	
	belongs_to :user
	belongs_to :blog_article
	
	validates_presence_of :body

	before_save :check_for_spam
	
	def validate
		if !self.user
			self.errors.add(:name, 'is required') if self.name.blank?
		end
	end

	def formatted_created_at
		self.created_at.strftime(BlogKit.instance.settings['post_date_format'] || '%m/%d/%Y at %I:%M%p')
	end
	
	def parsed_body
		# # Going to add markdown/html support later for comments
		# self.code_highlight_and_markdown(self.body, {:escape_html => true})
		
		self.body
	end
	
	def user_name
		name = self.user ? self.user.name : self.name
		if !self.site_url.blank?
			return "<a href=\"#{self.site_url}\">".html_safe << name << "</a>".html_safe
		else
			return name
		end
	end
	
	# Used to set more tracking for akismet
	def request=(request)
		self.user_ip    = request.remote_ip
	  self.user_agent = request.env['HTTP_USER_AGENT']
	  self.referrer   = request.env['HTTP_REFERER']
	end
	
	def check_for_spam
		if BlogKit.instance.settings['akismet_key'] && BlogKit.instance.settings['blog_url']
		  if Akismetor.spam?(akismet_attributes)
				self.errors.add_to_base('This comment has been detected as spam')
				return false
			else
				return true
			end
		end
	  true
	end

	def akismet_attributes
	  {
	    :key                  => BlogKit.instance.settings['akismet_key'],
	    :blog                 => BlogKit.instance.settings['blog_url'],
	    :user_ip              => user_ip,
	    :user_agent           => user_agent,
	    :comment_author       => name,
	    :comment_author_email => email,
	    :comment_author_url   => site_url,
	    :comment_content      => body
	  }
	end
	
end