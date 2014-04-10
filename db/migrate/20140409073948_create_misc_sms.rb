class CreateMiscSms < ActiveRecord::Migration
  def change
    create_table :misc_sms do |t|
      t.text :text
      t.integer :is_sent
      t.references :customer
      t.references :button_click
      t.string :vendor_id

      t.timestamps
    end
    add_index :misc_sms, :customer_id
    add_index :misc_sms, :button_click_id
  end
end
