class CreateUserBrandAccounts < ActiveRecord::Migration
  def change
    create_table :user_brand_accounts do |t|
      t.integer :user_account_id
      t.integer :account_brand_id

      t.timestamps
    end
  end
end
