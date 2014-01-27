class AddPurposeAndPlacementToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :purpose, :string
    add_column :campaigns, :placement, :string
  end
end
