class RemovePincodeFromAccounts < ActiveRecord::Migration
  def up
    remove_column :accounts, :pincode
  end

  def down
    add_column :accounts, :pincode, :integer
  end
end
