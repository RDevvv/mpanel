class RemoveLatestVersionIdFromAds < ActiveRecord::Migration
  def up
  	remove_column :ads, :latest_version_id
  end

  def down
  	add_column :ads, :latest_version_id, :integer
  end
end
