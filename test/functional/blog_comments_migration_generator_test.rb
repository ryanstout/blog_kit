require File.dirname(__FILE__) + '/../test_helper.rb'
require 'rails_generator'
require 'rails_generator/scripts/generate'

class BlogCommentsMigrationGeneratorTest < Test::Unit::TestCase
  def setup
    FileUtils.mkdir_p(fake_rails_root)
    @original_files = file_list
  end

  def teardown
    ActiveRecord::Base.pluralize_table_names = true
    FileUtils.rm_r(fake_rails_root)
  end

  def test_generates_correct_file_name
    Rails::Generator::Scripts::Generate.new.run(["blog_comments_migration"],
      :destination => fake_rails_root)
    new_file = (file_list - @original_files).first
    assert_match /create_blog_comments/, new_file
    assert_match /add_column :blog_comments do |t|/, File.read(new_file)
  end

  def test_pluralizes_properly
    ActiveRecord::Base.pluralize_table_names = false
    Rails::Generator::Scripts::Generate.new.run(["blog_comments_migration"],
      :destination => fake_rails_root)
    new_file = (file_list - @original_files).first
    assert_match /create_blog_comments/, new_file
    assert_match /add_column :blog_comments do |t|/, File.read(new_file)
  end

  private
    def fake_rails_root
      File.join(File.dirname(__FILE__), 'rails_root')
    end

    def file_list
      Dir.glob(File.join(fake_rails_root, "db", "migrate", "*"))
    end

end