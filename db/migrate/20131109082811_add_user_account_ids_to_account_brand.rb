class AddUserAccountIdsToAccountBrand < ActiveRecord::Migration
  def change
    add_column :account_brands, :user_acount_ids, :integer
  end
end
