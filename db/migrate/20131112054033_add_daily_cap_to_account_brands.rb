class AddDailyCapToAccountBrands < ActiveRecord::Migration
  def change
    add_column :account_brands, :daily_cap, :string
  end
end
