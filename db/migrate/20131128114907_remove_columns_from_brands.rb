class RemoveColumnsFromBrands < ActiveRecord::Migration
  def up
    remove_column :brands, :brand_alias
    remove_column :brands, :brand_code
    remove_column :brands, :daily_cap
  end

  def down
    add_column :brands, :daily_cap, :string
    add_column :brands, :brand_code, :string
    add_column :brands, :brand_alias, :string
  end
end
