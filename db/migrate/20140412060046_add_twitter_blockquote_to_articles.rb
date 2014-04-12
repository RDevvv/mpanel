class AddTwitterBlockquoteToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :twitter_blockquote, :string
  end
end
