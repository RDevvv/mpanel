class CreateBrandSessions < ActiveRecord::Migration
  def change
    create_table :brand_sessions do |t|
      t.references :brand
      t.references :customer_session

      t.timestamps
    end
    add_index :brand_sessions, :brand_id
    add_index :brand_sessions, :customer_session_id
  end
end
