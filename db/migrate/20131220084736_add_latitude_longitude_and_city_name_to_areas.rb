class AddLatitudeLongitudeAndCityNameToAreas < ActiveRecord::Migration
  def change
    add_column :areas, :latitude, :float
    add_column :areas, :longitude, :float
    add_column :areas, :city_name, :string
  end
end
