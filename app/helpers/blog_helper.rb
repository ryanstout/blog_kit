module BlogHelper
	def blog_tags_list
		html = []
		BlogTag.all(:select => 'tag,count(id) as count', :group => 'tag').each do |tag|
			html << "<li><a href=\"/blog_posts/tag/#{tag.tag}\">#{tag.tag}</a> (#{tag.count})</li>"
		end
		
		return "<div class=\"blogTagsList\"><ul>#{html.join}</ul></div>".html_safe
	end
end