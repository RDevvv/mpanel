class ChangeArticleCommentsSchema < ActiveRecord::Migration
  def change
    change_column :article_comments, :comment, :text
  end
end
