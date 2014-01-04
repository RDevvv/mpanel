class RemoveIsActiveFromAdGroups < ActiveRecord::Migration
  def up
  	remove_column :ad_groups, :is_active
  end

  def down
  	add_column :ad_groups, :is_active, :boolean
  end
end
