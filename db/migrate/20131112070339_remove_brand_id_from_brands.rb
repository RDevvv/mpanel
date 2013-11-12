class RemoveBrandIdFromBrands < ActiveRecord::Migration
  def up
    remove_column :brands, :brand_id
  end

  def down
    add_column :brands, :brand_id, :integer
  end
end
