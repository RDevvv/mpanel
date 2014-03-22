class CreateAdLikes < ActiveRecord::Migration
  def change
    create_table :ad_likes do |t|
      t.boolean :is_unlocked, :default => false
      t.references :customer
      t.references :ad
      t.references :outlet

      t.timestamps
    end
    add_index :ad_likes, :customer_id
    add_index :ad_likes, :ad_id
    add_index :ad_likes, :outlet_id
  end
end
