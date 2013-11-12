class RenameAddressLine1ToAddress < ActiveRecord::Migration
  def up
  	rename_column :account_brands, :address_line1, :address
  end

  def down
  	rename_column :account_brands, :address, :address_line1
  end
end
