class AddOutletIdsToAd < ActiveRecord::Migration
  def change
    add_column :ads, :outlet_ids, :integer
  end
end
