class CreateProductComments < ActiveRecord::Migration
  def change
    create_table :product_comments do |t|
      t.string :comment
      t.references :customer
      t.references :product

      t.timestamps
    end
    add_index :product_comments, :customer_id
    add_index :product_comments, :product_id
  end
end
