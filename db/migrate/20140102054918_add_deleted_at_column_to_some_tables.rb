class AddDeletedAtColumnToSomeTables < ActiveRecord::Migration
  def change
  	add_column :accounts, :deleted_at, :time
  	add_column :account_brands, :deleted_at, :time
  	add_column :ads, :deleted_at, :time
  	add_column :ad_groups, :deleted_at, :time
  	add_column :ad_keywords, :deleted_at, :time
  	add_column :ad_promocodes, :deleted_at, :time
  	add_column :ad_promocode_outlets, :deleted_at, :time
  	add_column :outlets, :deleted_at, :time
  	add_column :user_accounts, :deleted_at, :time
  end
end
