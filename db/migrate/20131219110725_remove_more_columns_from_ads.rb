class RemoveMoreColumnsFromAds < ActiveRecord::Migration
  def up
  	remove_column :ads, :ad_sent
  	remove_column :ads, :ad_views
  	remove_column :ads, :ad_shares
  end

  def down
  	add_column :ads, :ad_sent, :integer
  	add_column :ads, :ad_views, :integer
  	add_column :ads, :ad_shares, :integer
  end
end
