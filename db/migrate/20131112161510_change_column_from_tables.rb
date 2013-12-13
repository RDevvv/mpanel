class ChangeColumnFromTables < ActiveRecord::Migration
  def up
    change_column :accounts,:currency_id,:string
    remove_column :user_accounts,:account_brand_ids
    remove_column :account_brands,:user_account_ids
    remove_column :outlets,:ad_ids
    change_column :outlets,:mobile_number,:string
    change_column :outlets,:phone_number,:string
    # change_column :payment_values,:currency_id,:string
    remove_column :keywords,:ad_ids
    remove_column :ads,:outlet_ids
    remove_column :ads,:keyword_ids
    remove_column :ads,:lilfetime_budget
    add_column :ads,:lifetime_budget,:float
    change_column :outlet_versions,:mobile_number,:string
    change_column :outlet_versions,:phone_number,:string
    remove_column :brands,:account_ids
    change_column :accounts, :account_key, :string
    remove_column :accounts,:user_ids
    remove_column :accounts,:brand_ids
    remove_column :accounts,:admin_user_id
    
    remove_column :users,:account_ids
    change_column :users, :mobile_number, :string
    change_column :areas, :pincode, :string
    change_column :countries, :currency_id, :string


  end

  def down
  end
end
