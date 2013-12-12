class RenameKeywordsToKeyword < ActiveRecord::Migration
  def up
  	rename_column :keywords, :keywords, :keyword
  end

  def down
  	rename_column :keywords, :keyword, :keywords
  end
end
