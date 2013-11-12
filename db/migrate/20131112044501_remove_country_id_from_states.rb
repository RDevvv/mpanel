class RemoveCountryIdFromStates < ActiveRecord::Migration
  def up
    remove_column :states, :country_id
  end

  def down
    add_column :states, :country_id, :string
  end
end
