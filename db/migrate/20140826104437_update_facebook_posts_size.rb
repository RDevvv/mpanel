class UpdateFacebookPostsSize < ActiveRecord::Migration
  def change
    change_column :facebook_posts, :post_text, :text
    add_column :facebook_posts, :facebook_post_id, :string
    add_column :facebook_posts, :image_url, :string
  end
end
