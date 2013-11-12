class CreateSingleCodeAnyOutlets < ActiveRecord::Migration
  def change
    create_table :single_code_any_outlets do |t|
      t.integer :ad_id
      t.string :promocode
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
