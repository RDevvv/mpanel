class AddCampaignUrlToCampaignCopiesTable < ActiveRecord::Migration
  def change
    add_column :customer_sessions, :campaign_url, :string
  end
end
