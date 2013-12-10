class AddIsActiveToAdPromocodes < ActiveRecord::Migration
  def change
    add_column :ad_promocodes, :is_active, :boolean
  end
end
