class RemoveAddressLine2FromAccounts < ActiveRecord::Migration
  def up
    remove_column :accounts, :address_line2
  end

  def down
    add_column :accounts, :address_line2, :text
  end
end
