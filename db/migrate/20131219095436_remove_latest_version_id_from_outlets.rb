class RemoveLatestVersionIdFromOutlets < ActiveRecord::Migration
  def up
  	remove_column :outlets, :latest_version_id
  end

  def down
  	add_column :outlets, :latest_version_id, :integer
  end
end
