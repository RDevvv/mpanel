class CreateMalls < ActiveRecord::Migration
  def change
    create_table :malls do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.integer :area_id

      t.timestamps
    end
  end
end
