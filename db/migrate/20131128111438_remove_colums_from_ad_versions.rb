class RemoveColumsFromAdVersions < ActiveRecord::Migration
  def up
    remove_column :ad_versions, :version_id
    remove_column :ad_versions, :ad_type
    remove_column :ad_versions, :promocode_type_id
    remove_column :ad_versions, :daily_cap
    remove_column :ad_versions, :lilfetime_budget
  end

  def down
    add_column :ad_versions, :lilfetime_budget, :float
    add_column :ad_versions, :daily_cap, :string
    add_column :ad_versions, :promocode_type_id, :integer
    add_column :ad_versions, :ad_type, :string
    add_column :ad_versions, :version_id, :integer
  end
end
