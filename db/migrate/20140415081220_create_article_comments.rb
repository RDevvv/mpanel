class CreateArticleComments < ActiveRecord::Migration
  def change
    create_table :article_comments do |t|
      t.string :name
      t.string :comment
      t.string :email
      t.integer :commentable_id
      t.string :commentable_type

      t.timestamps
    end
  end
end
