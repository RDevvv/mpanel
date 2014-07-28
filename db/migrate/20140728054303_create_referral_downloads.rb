class CreateReferralDownloads < ActiveRecord::Migration
  def change
    create_table :referral_downloads do |t|
      t.references :referrer
      t.references :referee
      t.boolean :is_calculated, :default => false

      t.timestamps
    end
    add_index :referral_downloads, :referrer_id
    add_index :referral_downloads, :referee_id
  end
end
