class AddShortUrlToCampaignCopies < ActiveRecord::Migration
  def change
    add_column :campaign_copies, :short_url, :string
  end
end
