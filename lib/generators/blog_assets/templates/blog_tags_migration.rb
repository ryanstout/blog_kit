class CreateBlogTags < ActiveRecord::Migration
  def self.up
    create_table :blog_tags do |t|
			t.column :blog_post_id, :integer
			t.column :tag, :string, :null => false
    end

    add_index :blog_tags, :blog_post_id
    add_index :blog_tags, :tag
  end
  
  def self.down
    drop_table :blog_tags
  end
end