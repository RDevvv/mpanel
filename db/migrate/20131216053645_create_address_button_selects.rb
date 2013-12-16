class CreateAddressButtonSelects < ActiveRecord::Migration
  def change
    create_table :address_button_selects do |t|
      t.references :customer

      t.timestamps
    end
    add_index :address_button_selects, :customer_id
  end
end
