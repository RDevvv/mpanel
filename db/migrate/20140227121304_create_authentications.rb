class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.references :customer
      t.string :uid

      t.timestamps
    end
    add_index :authentications, :customer_id
  end
end
