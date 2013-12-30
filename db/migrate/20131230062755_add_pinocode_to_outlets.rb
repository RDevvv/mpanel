class AddPinocodeToOutlets < ActiveRecord::Migration
  def change
    add_column :outlets,:pincode,:string
  end
end
