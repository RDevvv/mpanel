class CreateCustomerLocations < ActiveRecord::Migration
  def change
    create_table :customer_locations do |t|
      t.float :latitude
      t.float :longitude
      t.references :customer

      t.timestamps
    end
    add_index :customer_locations, :customer_id
  end
end
