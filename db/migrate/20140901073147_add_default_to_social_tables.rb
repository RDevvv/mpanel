class AddDefaultToSocialTables < ActiveRecord::Migration
  def change
    remove_column :brands, :facebook_likes_count
    add_column :brands, :facebook_likes_count, :integer, :null => false, :default => 0
    change_column :brands, :twitter_followers_count, :integer, :null => false, :default => 0
    change_column :facebook_posts, :likes, :integer, :null => false, :default => 0
    change_column :facebook_posts, :comments, :integer, :null => false, :default => 0
    change_column :tweets, :retweets, :integer, :null => false, :default => 0
    change_column :tweets, :favorite, :integer, :null => false, :default => 0
  end
end
