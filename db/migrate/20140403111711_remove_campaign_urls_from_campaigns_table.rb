class RemoveCampaignUrlsFromCampaignsTable < ActiveRecord::Migration
  def up
      remove_column :campaigns, :unique_key
      remove_column :campaigns, :pre_expiry_forward_url
      remove_column :campaigns, :post_expiry_forward_url
      remove_column :campaigns, :short_url
      add_column    :campaigns, :expires_in, :timestamp
  end
end
