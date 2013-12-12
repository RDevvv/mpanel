class AddAdGroupIdToAdPromocodes < ActiveRecord::Migration
  def change
    add_column :ad_promocodes, :ad_group_id, :integer
  end
end
