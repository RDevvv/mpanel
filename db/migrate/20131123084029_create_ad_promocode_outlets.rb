class CreateAdPromocodeOutlets < ActiveRecord::Migration
  def change
    create_table :ad_promocode_outlets do |t|
      t.integer :ad_id
      t.integer :outlet_id
      t.integer :ad_promocode_id

      t.timestamps
    end
  end
end
