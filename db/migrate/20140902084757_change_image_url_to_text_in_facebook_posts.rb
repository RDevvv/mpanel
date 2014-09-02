class ChangeImageUrlToTextInFacebookPosts < ActiveRecord::Migration
  def change
    change_column :facebook_posts, :image_url, :text
  end
end
