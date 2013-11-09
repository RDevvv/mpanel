class AddBrandIdsToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :brand_ids, :integer
  end
end
