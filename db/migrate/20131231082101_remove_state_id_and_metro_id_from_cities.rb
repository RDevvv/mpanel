class RemoveStateIdAndMetroIdFromCities < ActiveRecord::Migration
  def up
  	remove_column :cities, :state_id
  	remove_column :cities, :metro_id
  end

  def down
  	add_column :cities, :state_id, :integer
  	add_column :cities, :metro_id, :integer
  end
end
