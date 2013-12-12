class AddDeletedAtToOutlets < ActiveRecord::Migration
  def change
    add_column :outlets, :deleted_at, :time
  end
end
