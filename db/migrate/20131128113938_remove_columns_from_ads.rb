class RemoveColumnsFromAds < ActiveRecord::Migration
  def up
    remove_column :ads, :ad_type
    remove_column :ads, :promocode_type_id
    remove_column :ads, :daily_cap
    remove_column :ads, :lifetime_budget
  end

  def down
    add_column :ads, :lifetime_budget, :float
    add_column :ads, :daily_cap, :string
    add_column :ads, :promocode_type_id, :integer
    add_column :ads, :ad_type, :string
  end
end
