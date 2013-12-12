class AddColumnsToOutletVersions < ActiveRecord::Migration
  def change
    add_column :outlet_versions, :outlet_views, :integer
    add_column :outlet_versions, :outlet_calls, :integer
    add_column :outlet_versions, :outlet_impressions, :boolean
  end
end
