class RenameAddressLine1ToAddress < ActiveRecord::Migration
  def up
  	rename_column :accounts, :address_line1, :address
  end

  def down
  	rename_column :accounts, :address, :address_line1
  end
end
