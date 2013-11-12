class RemoveCityIdFromAccounts < ActiveRecord::Migration
  def up
    remove_column :accounts, :city_id
  end

  def down
    add_column :accounts, :city_id, :integer
  end
end
