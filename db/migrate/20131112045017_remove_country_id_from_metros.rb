class RemoveCountryIdFromMetros < ActiveRecord::Migration
  def up
    remove_column :metros, :country_id
  end

  def down
    add_column :metros, :country_id, :string
  end
end
