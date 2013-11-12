class AddAdIdsToOutlet < ActiveRecord::Migration
  def change
    add_column :outlets, :ad_ids, :integer
  end
end
