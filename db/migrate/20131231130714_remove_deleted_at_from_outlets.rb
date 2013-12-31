class RemoveDeletedAtFromOutlets < ActiveRecord::Migration
  def up
  	remove_column :outlets, :deleted_at
  end

  def down
  	add_column :outlets, :deleted_at, :boolean
  end
end
