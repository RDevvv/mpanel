class RemoveCityNameFromAreas < ActiveRecord::Migration
  def up
  	remove_column :areas, :city_name
  end

  def down
  	add_column :areas, :city_name, :string
  end
end
