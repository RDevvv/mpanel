class AddFieldsToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :ad_promocode_outlet_id, :integer
  end
end
