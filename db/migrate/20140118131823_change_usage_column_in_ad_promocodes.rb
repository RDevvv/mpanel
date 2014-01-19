class ChangeUsageColumnInAdPromocodes < ActiveRecord::Migration
  def up
      change_column :ad_promocodes, :usage, :float, :default => 0
  end

  def down
  end
end
