class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.integer :brand_id
      t.string :brand_name
      t.string :brand_alias
      t.string :brand_code
      t.integer :category_id
      t.string :website_url
      t.boolean :is_active
      t.boolean :is_verified

      t.timestamps
    end
  end
end
