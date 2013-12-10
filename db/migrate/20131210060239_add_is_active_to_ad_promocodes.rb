class AddIsActiveToAdPromocodes < ActiveRecord::Migration
  def change
    add_column :ad_promocodes, :is_active, :boolean,:default=>true
  end
end
