class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.integer :state_id
      t.string :city_name
      t.integer :metro_id
      t.string :time_zone

      t.timestamps
    end
  end
end
