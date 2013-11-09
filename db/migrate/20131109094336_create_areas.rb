class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.integer :city_id
      t.string :area_name
      t.integer :pincode
      t.string :area_alias

      t.timestamps
    end
  end
end
