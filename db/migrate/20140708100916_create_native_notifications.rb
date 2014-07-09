class CreateNativeNotifications < ActiveRecord::Migration
  def change
    create_table :native_notifications do |t|
      t.references :ad
      t.references :customer

      t.timestamps
    end
    add_index :native_notifications, :ad_id
    add_index :native_notifications, :customer_id
  end
end
