require 'rubygems'
begin
	require 'bluecloth'
rescue Exception => e
	require 'erb'
	puts "Could not load bluecloth #{e.inspect}"
end
begin
	require 'uv'
rescue Exception => e
	require 'erb'
	puts "Could not load UltraViolet"
end

module BlogKitModelHelper
	def code_highlight_and_markdown(text, markdown_options = {})
    text_pieces = text.split(/(<code>|<code lang="[A-Za-z0-9_-]+">|
      <code lang='[A-Za-z0-9_-]+'>|<\/code>)/)
    in_pre = false
    language = nil
    post = text_pieces.collect do |piece|
      if piece =~ /^<code( lang=(["'])?(.*)\2)?>$/
        language = $3
        in_pre = true
        nil
      elsif piece == "</code>"
        in_pre = false
        language = nil
        nil
      elsif in_pre
        lang = language ? language : "ruby"
				if defined?(Uv)
	        "<div class=\"blogKitCode\">" + Uv.parse( piece.strip, "xhtml", lang, BlogKit.instance.settings['show_line_numbers'] || false, BlogKit.instance.settings['theme'] || 'mac_classic') + "</div>"
				else
					"<code>#{ERB::Util.html_escape(piece)}</code>"
				end
      else
				if defined?(BlueCloth)
	        BlueCloth.new(piece, markdown_options).to_html
				else
					ERB::Util.html_escape(piece)
				end
      end
    end.join('')

		return post.html_safe if post.respond_to?(:html_safe)
		return post
	end
	
	def user_image_tag
		if self.user && self.user.respond_to?(:blog_image_url) && self.user.blog_image_url
			# Load image from model
			ret = "<img src=\"#{self.user.blog_image_url}\" />"
		elsif BlogKit.instance.settings['gravatar']
			# Gravatar
			require 'digest/md5'
			if self.respond_to?(:email) && !self.email.blank?
				email = self.email
			elsif self.user && self.user.respond_to?(:email) && !self.user.email.blank?
				email = self.user.email
			else
				return ''
			end
			
			hash = Digest::MD5.hexdigest(email.downcase)
			ret = "<img src=\"http://www.gravatar.com/avatar/#{hash}.jpg\" />"
		else
			# No Image
			return ''
		end
		
		return ret.html_safe if ret.respond_to?(:html_safe)
		return ret
	end
end