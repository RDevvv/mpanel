class CreateOutletAds < ActiveRecord::Migration
  def change
    create_table :outlet_ads do |t|
      t.integer :ad_id
      t.integer :outlet_id
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
