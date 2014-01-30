class AddVendorIdToCampaignCopies < ActiveRecord::Migration
  def change
    add_column :campaign_copies, :vendor_id, :integer
  end
end
