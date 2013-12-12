class AddColumnsToOutlets < ActiveRecord::Migration
  def change
    add_column :outlets, :outlet_views, :integer
    add_column :outlets, :outlet_calls, :integer
    add_column :outlets, :outlet_impressions, :integer
  end
end
