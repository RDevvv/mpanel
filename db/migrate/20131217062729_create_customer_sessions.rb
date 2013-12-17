class CreateCustomerSessions < ActiveRecord::Migration
  def change
    create_table :customer_sessions do |t|
      t.references :customer
      t.string :browser
      t.string :platform
      t.string :browser_version
      t.string :referer_link

      t.timestamps
    end
    add_index :customer_sessions, :customer_id
  end
end
