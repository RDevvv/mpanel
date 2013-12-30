class RemovePincodeFromOutlets < ActiveRecord::Migration
  def up
    remove_column :outlets,:pincode
    add_column :outlets,:pincode_id,:integer
  end

  def down
  end
end
