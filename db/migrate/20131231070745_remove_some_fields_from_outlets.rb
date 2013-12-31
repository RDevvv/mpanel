class RemoveSomeFieldsFromOutlets < ActiveRecord::Migration
  def up
  	remove_column :outlets, :outlet_type_id
  	remove_column :outlets, :mobile_country_id
  	remove_column :outlets, :outlet_views
  	remove_column :outlets, :outlet_calls
  	remove_column :outlets, :outlet_impressions
  end

  def down
  	add_column :outlets, :outlet_type_id, :integer
  	add_column :outlets, :mobile_country_id, :integer
  	add_column :outlets, :outlet_views, :integer
  	add_column :outlets, :outlet_calls, :integer
  	add_column :outlets, :outlet_impressions, :integer
  end
end
