class AddShopNoToOutlets < ActiveRecord::Migration
  def change
    add_column :outlets, :shop_no, :string
  end
end
