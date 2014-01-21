class AddUsageToAds < ActiveRecord::Migration
  def change
    add_column :ads, :usage, :integer, :default => 0
  end
end
