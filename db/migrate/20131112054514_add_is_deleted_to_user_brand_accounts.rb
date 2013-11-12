class AddIsDeletedToUserBrandAccounts < ActiveRecord::Migration
  def change
    add_column :user_brand_accounts, :is_deleted, :integer
  end
end
