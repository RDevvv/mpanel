class AddLatitudeAndLongitudeToCustomerSessions < ActiveRecord::Migration
  def change
    add_column :customer_sessions, :longitude, :float
    add_column :customer_sessions, :latitude, :float
  end
end
