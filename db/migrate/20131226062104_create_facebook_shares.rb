class CreateFacebookShares < ActiveRecord::Migration
  def change
    create_table :facebook_shares do |t|
      t.references :ad
      t.references :customer

      t.timestamps
    end
    add_index :facebook_shares, :ad_id
    add_index :facebook_shares, :customer_id
  end
end
