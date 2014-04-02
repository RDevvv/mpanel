class CreateCustomerBrandScores < ActiveRecord::Migration
  def change
    create_table :customer_brand_scores do |t|
      t.integer :customer_id
      t.integer :brand_id
      t.integer :category_like
      t.integer :brand_like
      t.integer :view_count
      t.integer :call_count
      t.integer :unlock_count
      t.integer :share_count
      t.integer :score

      t.timestamps
    end
  end
end
