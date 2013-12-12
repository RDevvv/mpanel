class RemoveColumnsFromOutletVersions < ActiveRecord::Migration
  def up
    remove_column :outlet_versions, :version_id
    remove_column :outlet_versions, :outlet_name
    remove_column :outlet_versions, :outlet_alias
    remove_column :outlet_versions, :payment_value_id
    remove_column :outlet_versions, :daily_cap
  end

  def down
    add_column :outlet_versions, :daily_cap, :string
    add_column :outlet_versions, :payment_value_id, :integer
    add_column :outlet_versions, :outlet_alias, :string
    add_column :outlet_versions, :outlet_name, :string
    add_column :outlet_versions, :version_id, :integer
  end
end
