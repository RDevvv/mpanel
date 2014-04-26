class ChangeDataTypeForTwitterBlockquoteColumnsOfArticles < ActiveRecord::Migration
  def up
    change_column :articles, :twitter_blockquote, :text
  end

  def down
    change_column :articles, :twitter_blockquote, :string
  end
end
