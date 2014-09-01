class AddCoverUrlToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :cover_url, :string
  end
end
