class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.text :keywords
      t.integer :ad_ids

      t.timestamps
    end
  end
end
