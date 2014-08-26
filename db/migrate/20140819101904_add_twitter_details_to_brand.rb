class AddTwitterDetailsToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :twitter_followers_count, :integer, :default => 0
    add_column :brands, :twitter_handle, :string
    add_column :brands, :facebook_handle, :string
  end
end
