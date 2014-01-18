class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title
      t.string :body
      t.integer :article_id
      t.integer :commentable_id
      t.string :commentable_type

      t.timestamps
    end
  end
end
