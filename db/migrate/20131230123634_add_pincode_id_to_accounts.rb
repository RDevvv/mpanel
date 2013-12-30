class AddPincodeIdToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :pincode_id, :integer
  end
end
