atom_feed do |feed|
  feed.title(BlogKit.instance.settings['blog_name'])
  feed.update(@blog_posts.first.created_at) if @blog_posts.first
  
  @blog_posts.each do |post|
    feed.entry(post) do |entry|
      entry.title(post.title)
      entry.content(post.parsed_body, :type => 'html')
      entry.author { |author| author.name(post.user_name(true)) }
    end
  end
end