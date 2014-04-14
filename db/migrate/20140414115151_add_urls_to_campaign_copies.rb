class AddUrlsToCampaignCopies < ActiveRecord::Migration
  def change
    add_column :campaign_copies, :pre_expiry_forward_url, :string
    add_column :campaign_copies, :post_expiry_forward_url, :string
  end
end
