class AddAccountIdsToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :account_ids, :integer
  end
end
