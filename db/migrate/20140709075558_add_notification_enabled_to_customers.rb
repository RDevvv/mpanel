class AddNotificationEnabledToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :notification_enabled, :boolean, :default => true
  end
end
