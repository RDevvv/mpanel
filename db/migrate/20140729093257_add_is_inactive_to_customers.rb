class AddIsInactiveToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :is_inactive, :boolean, :default => false
  end
end
