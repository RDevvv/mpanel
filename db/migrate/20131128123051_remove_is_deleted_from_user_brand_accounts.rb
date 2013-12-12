class RemoveIsDeletedFromUserBrandAccounts < ActiveRecord::Migration
  def up
    remove_column :user_brand_accounts, :is_deleted
  end

  def down
    add_column :user_brand_accounts, :is_deleted, :integer
  end
end
