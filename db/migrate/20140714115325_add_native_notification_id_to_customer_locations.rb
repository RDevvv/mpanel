class AddNativeNotificationIdToCustomerLocations < ActiveRecord::Migration
  def change
    add_column :customer_locations, :native_notification_id, :integer
  end
end
