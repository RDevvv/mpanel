class SetDefaultValuesOfOutletsToFalse < ActiveRecord::Migration
  def up
  	change_column :outlets, :is_active, :boolean, :default => false
  	change_column :outlets, :is_verified, :boolean, :default => false
  end

  def down
  	change_column :outlets, :is_active, :boolean, :default => true
  	change_column :outlets, :is_verified, :boolean, :default => true
  end
end
