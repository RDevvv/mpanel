class AddProductLikesCountToProducts < ActiveRecord::Migration
  def change
    add_column :products, :product_likes_count, :integer, :default => 0
  end
end
