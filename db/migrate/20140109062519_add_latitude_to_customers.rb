class AddLatitudeToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :latitude, :float
  end
end
