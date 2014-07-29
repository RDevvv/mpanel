class CreateReferrerDownloadCounts < ActiveRecord::Migration
  def change
    create_table :referrer_download_counts do |t|
      t.references :customer
      t.integer :download_count, :default => 0

      t.timestamps
    end
    add_index :referrer_download_counts, :customer_id
  end
end
