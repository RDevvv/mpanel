class RenameBrandAccountIdToAccountBrandIdOfAds < ActiveRecord::Migration
  def up
  	rename_column :ads, :brand_account_id, :account_brand_id
  end

  def down
  	rename_column :ads, :account_brand_id, :brand_account_id
  end
end
