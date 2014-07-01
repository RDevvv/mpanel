class CreateCustomerKeywords < ActiveRecord::Migration
  def change
    create_table :customer_keywords do |t|
      t.references :customer
      t.references :keyword

      t.timestamps
    end
    add_index :customer_keywords, :customer_id
    add_index :customer_keywords, :keyword_id
  end
end
