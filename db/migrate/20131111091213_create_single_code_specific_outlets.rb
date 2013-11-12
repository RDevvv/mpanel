class CreateSingleCodeSpecificOutlets < ActiveRecord::Migration
  def change
    create_table :single_code_specific_outlets do |t|
      t.integer :ad_outlet_id
      t.string :promocode
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
