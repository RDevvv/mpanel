class CreateMultipleCodesSpecificOutlets < ActiveRecord::Migration
  def change
    create_table :multiple_codes_specific_outlets do |t|
      t.integer :ad_outlet_id
      t.string :promocode
      t.boolean :is_used
      t.datetime :start_date
      t.datetime :start_date
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
