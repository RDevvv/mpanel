class CreateProductLikes < ActiveRecord::Migration
  def change
    create_table :product_likes do |t|
      t.references :product
      t.references :customer

      t.timestamps
    end
    add_index :product_likes, :product_id
    add_index :product_likes, :customer_id
  end
end
