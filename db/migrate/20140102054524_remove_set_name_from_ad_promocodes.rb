class RemoveSetNameFromAdPromocodes < ActiveRecord::Migration
  def up
  	remove_column :ad_promocodes, :set_name
  end

  def down
  	add_column :ad_promocodes, :set_name, :integer
  end
end
