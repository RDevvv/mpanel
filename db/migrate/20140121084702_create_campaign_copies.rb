class CreateCampaignCopies < ActiveRecord::Migration
  def change
    create_table :campaign_copies do |t|
      t.references :campaign
      t.datetime :expires_at
      t.boolean :is_sent, :default => false
      t.boolean :is_delivered, :default => false
      t.boolean :is_opened, :default => false
      t.references :customer
      t.integer :copy_sent
      t.integer :use_count, :default => 0

      t.timestamps
    end
    add_index :campaign_copies, :campaign_id
    add_index :campaign_copies, :customer_id
  end
end
