class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.text :address_line1
      t.text :address_line2
      t.integer :area_id
      t.integer :city_id
      t.integer :pincode
      t.integer :currency_id
      t.string :payment_status
      t.float :account_balance
      t.integer :account_key
      t.boolean :is_active
      t.integer :admin_user_id
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
