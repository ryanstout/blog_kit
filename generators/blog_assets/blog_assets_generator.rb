class BlogAssetsGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.migration_template 'blog_comments_migration.rb', "db/migrate", {:migration_file_name => "create_blog_comments"}
      m.migration_template 'blog_posts_migration.rb', "db/migrate", {:migration_file_name => "create_blog_posts"}
			m.file "config/blog_kit.yml", "config/blog_kit.yml"
			m.file "blog_kit.css", "public/stylesheets/blog_kit.css"
    end
  end
end