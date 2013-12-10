class AddAdIdToAdGroups < ActiveRecord::Migration
  def change
    add_column :ad_groups, :ad_id, :integer
  end
end
