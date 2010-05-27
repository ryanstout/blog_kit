class CreateBlogComments < ActiveRecord::Migration
  def self.up
    create_table :blog_comments do |t|
			t.column :blog_post_id, :integer
			t.column :user_id, :integer
			t.column :user_ip, :string
			t.column :user_agent, :string
			t.column :referrer, :string
			t.column :name, :string
			t.column :site_url, :string
			t.column :email, :string
			t.column :body, :text
			t.column :created_at, :datetime
    end

    add_index :blog_comments, :blog_post_id
  end
  
  def self.down
    remove_index :blog_comments, :blog_post_id
    drop_table :blog_comments
  end
end