class CreateButtonClicks < ActiveRecord::Migration
  def change
    create_table :button_clicks do |t|
      t.references :customer
      t.string :button_class
      t.integer :ad_id

      t.timestamps
    end
    add_index :button_clicks, :customer_id
  end
end
