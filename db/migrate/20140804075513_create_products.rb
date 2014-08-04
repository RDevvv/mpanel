class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.references :account_brand
      t.float :price

      t.timestamps
    end
    add_index :products, :account_brand_id
  end
end
