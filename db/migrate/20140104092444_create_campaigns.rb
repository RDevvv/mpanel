class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :source
      t.string :medium
      t.string :marketer
      t.string :type
      t.string :keyword
      t.string :pre_expiry_forward_url
      t.string :post_expiry_forward_url
      t.string :short_url
      t.string :unique_key
      t.timestamp :expires_at

      t.timestamps
    end
  end
end
