class CreateBlogImages < ActiveRecord::Migration
  def self.up
    create_table :blog_images, :force => true do |t|
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      t.integer :blog_post_id
      t.timestamps
    end

    add_index :blog_images, :blog_post_id
  end

  def self.down
    remove_index :blog_images, :blog_post_id
    drop_table :blog_images
  end
end