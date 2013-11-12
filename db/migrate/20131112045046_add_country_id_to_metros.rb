class AddCountryIdToMetros < ActiveRecord::Migration
  def change
    add_column :metros, :country_id, :integer
  end
end
