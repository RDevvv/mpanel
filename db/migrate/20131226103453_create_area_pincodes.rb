class CreateAreaPincodes < ActiveRecord::Migration
  def change
    create_table :area_pincodes do |t|
      t.integer :area_id
      t.integer :pincode_id

      t.timestamps
    end
  end
end
