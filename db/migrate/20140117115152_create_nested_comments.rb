class CreateNestedComments < ActiveRecord::Migration
  def change
    create_table :nested_comments do |t|
      t.integer :parent_id
      t.integer :comment_id

      t.timestamps
    end
  end
end
