class AddColumnKeywordAliasToKeywords < ActiveRecord::Migration
  def change
    add_column :keywords, :keyword_alias, :string
  end
end
