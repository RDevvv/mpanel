class AddColumsToAds < ActiveRecord::Migration
  def change
    add_column :ads, :ad_sent, :integer
    add_column :ads, :ad_views, :integer
    add_column :ads, :ad_shares, :integer
    add_column :ads, :is_exclusive, :boolean
  end
end
