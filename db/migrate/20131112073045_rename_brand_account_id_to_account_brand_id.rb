class RenameBrandAccountIdToAccountBrandId < ActiveRecord::Migration
  def up
  	rename_column :outlet_versions, :brand_account_id, :account_brand_id
  end

  def down
  	rename_column :outlet_versions, :account_brand_id, :brand_account_id
  end
end
