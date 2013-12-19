class SetDefaultValuesOfOutlets < ActiveRecord::Migration
  def up
  	change_column :outlets, :is_active, :boolean, :default => true
  	change_column :outlets, :is_verified, :boolean, :default => true
  end

  def down
  	change_column :outlets, :is_active, :boolean, :default => nil
  	change_column :outlets, :is_verified, :boolean, :default => nil
  end
end
