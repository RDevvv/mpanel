class AddColumnsToAdVersions < ActiveRecord::Migration
  def change
    add_column :ad_versions, :lifetime_budget, :float
    add_column :ad_versions, :ad_sent, :integer
    add_column :ad_versions, :ad_views, :integer
    add_column :ad_versions, :ad_shares, :integer
    add_column :ad_versions, :is_exclusive, :boolean
  end
end
