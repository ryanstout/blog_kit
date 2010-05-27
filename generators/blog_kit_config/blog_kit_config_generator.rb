class BlogKitConfigGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.file "config/blog_kit.yml", "config/blog_kit.yml"
    end
  end
end