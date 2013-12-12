class RemoveColumnsFromOutlets < ActiveRecord::Migration
  def up
    remove_column :outlets, :outlet_name
    remove_column :outlets, :outlet_alias
    remove_column :outlets, :payment_value_id
    remove_column :outlets, :daily_cap
  end

  def down
    add_column :outlets, :daily_cap, :string
    add_column :outlets, :payment_value_id, :integer
    add_column :outlets, :outlet_alias, :string
    add_column :outlets, :outlet_name, :string
  end
end
