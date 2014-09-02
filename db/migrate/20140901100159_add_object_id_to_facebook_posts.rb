class AddObjectIdToFacebookPosts < ActiveRecord::Migration
  def change
    add_column :facebook_posts, :post_url, :string
  end
end
