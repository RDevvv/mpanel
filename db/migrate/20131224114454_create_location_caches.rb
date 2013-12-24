class CreateLocationCaches < ActiveRecord::Migration
  def change
    create_table :location_caches do |t|
      t.float :longitude
      t.float :latitude
      t.string :location

      t.timestamps
    end
  end
end
