class AddUseCountToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :use_count, :integer, :default => 0
  end
end
