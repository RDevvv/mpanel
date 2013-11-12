class CreateKeywordAliases < ActiveRecord::Migration
  def change
    create_table :keyword_aliases do |t|
      t.integer :keyword_id
      t.string :alias_name

      t.timestamps
    end
  end
end
