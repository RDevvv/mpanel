class AddCustomerIpToCustomerSessions < ActiveRecord::Migration
  def change
    add_column :customer_sessions, :customer_ip, :string
  end
end
