class AddAccountBrandIdsToUserAccount < ActiveRecord::Migration
  def change
    add_column :user_accounts, :account_brand_ids, :integer
  end
end
