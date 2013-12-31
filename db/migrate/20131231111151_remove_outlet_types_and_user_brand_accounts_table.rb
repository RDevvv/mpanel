class RemoveOutletTypesAndUserBrandAccountsTable < ActiveRecord::Migration
  def up
		drop_table :outlet_types if ActiveRecord::Base.connection.table_exists? 'outlet_types'
		drop_table :user_brand_accounts if ActiveRecord::Base.connection.table_exists? 'user_brand_accounts'
  end

  def down
  end
end
