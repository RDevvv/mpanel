class CreateCallForwardings < ActiveRecord::Migration
  def change
    create_table :call_forwardings do |t|
      t.references :outlet
      t.references :customer

      t.timestamps
    end
    add_index :call_forwardings, :outlet_id
    add_index :call_forwardings, :customer_id
  end
end
