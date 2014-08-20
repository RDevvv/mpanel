class CreateFacebookPosts < ActiveRecord::Migration
  def change
    create_table :facebook_posts do |t|
      t.string :post_text
      t.integer :likes
      t.integer :comments
      t.references :brand

      t.timestamps
    end
    add_index :facebook_posts, :brand_id
  end
end
