class CreateAdKeywords < ActiveRecord::Migration
  def change
    create_table :ad_keywords do |t|
      t.integer :ad_id
      t.integer :keyword_id
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
