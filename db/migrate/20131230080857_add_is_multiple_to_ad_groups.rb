class AddIsMultipleToAdGroups < ActiveRecord::Migration
  def change
    add_column :ad_groups, :is_multiple, :boolean,:default=>false
  end
end
