class RenameUserAcountIdsToUserAccountIds < ActiveRecord::Migration
  def up
  	rename_column :account_brands, :user_acount_ids, :user_account_ids
  end

  def down
  	rename_column :account_brands, :user_account_ids, :user_acount_ids
  end
end
