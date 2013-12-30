class RemovePincodeFromAreas < ActiveRecord::Migration
  def up
    remove_column :areas,:pincode
  end

  def down
  end
end
