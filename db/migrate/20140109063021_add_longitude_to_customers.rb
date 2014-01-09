class AddLongitudeToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :longitude, :float
  end
end
