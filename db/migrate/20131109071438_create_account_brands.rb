class CreateAccountBrands < ActiveRecord::Migration
  def change
    create_table :account_brands do |t|
      t.integer :brand_id
      t.integer :account_id
      t.boolean :is_active

      t.timestamps
    end
  end
end
