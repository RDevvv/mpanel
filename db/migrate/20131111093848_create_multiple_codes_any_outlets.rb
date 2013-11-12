class CreateMultipleCodesAnyOutlets < ActiveRecord::Migration
  def change
    create_table :multiple_codes_any_outlets do |t|
      t.integer :ad_id
      t.string :promocode
      t.boolean :is_used
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
