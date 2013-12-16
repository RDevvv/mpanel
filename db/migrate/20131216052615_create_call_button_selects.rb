class CreateCallButtonSelects < ActiveRecord::Migration
  def change
    create_table :call_button_selects do |t|
      t.references :customer

      t.timestamps
    end
    add_index :call_button_selects, :customer_id
  end
end
