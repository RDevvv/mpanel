class AddAccountIdsToUser < ActiveRecord::Migration
  def change
    add_column :users, :account_ids, :integer
  end
end
