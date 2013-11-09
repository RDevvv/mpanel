class AddUserIdsToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :user_ids, :integer
  end
end
