class RemoveIsActiveAndDailyCapColumnsFromAccountBrands < ActiveRecord::Migration
  def up
    remove_column :account_brands, :is_active
    remove_column :account_brands, :daily_cap
  end

  def down
    add_column :account_brands, :daily_cap, :string
    add_column :account_brands, :is_active, :boolean
  end
end
