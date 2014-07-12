class CreateCustomerCampaignCopies < ActiveRecord::Migration
  def change
    create_table :customer_campaign_copies do |t|
      t.references :customer
      t.references :campaign_copy
      t.string :customer_ip

      t.timestamps
    end
    add_index :customer_campaign_copies, :customer_id
    add_index :customer_campaign_copies, :campaign_copy_id
  end
end
