class AddDefaultValuesToAds < ActiveRecord::Migration
  def up
  	change_column :ads, :is_active, :boolean, :default => true
  	change_column :ads, :is_exclusive, :boolean, :default => false
  	change_column :ads, :is_monday, :boolean, :default => false
  	change_column :ads, :is_tuesday, :boolean, :default => false
  	change_column :ads, :is_wednesday, :boolean, :default => false
  	change_column :ads, :is_thursday, :boolean, :default => false
  	change_column :ads, :is_friday, :boolean, :default => false
  	change_column :ads, :is_saturday, :boolean, :default => false
  	change_column :ads, :is_sunday, :boolean, :default => false
  end

  def down
  	change_column :ads, :is_active, :boolean, :default => nil
  	change_column :ads, :is_exclusive, :boolean, :default => nil
  	change_column :ads, :is_monday, :boolean, :default => nil
  	change_column :ads, :is_tuesday, :boolean, :default => nil
  	change_column :ads, :is_wednesday, :boolean, :default => nil
  	change_column :ads, :is_thursday, :boolean, :default => nil
  	change_column :ads, :is_friday, :boolean, :default => nil
  	change_column :ads, :is_saturday, :boolean, :default => nil
  	change_column :ads, :is_sunday, :boolean, :default => nil
  end
end
