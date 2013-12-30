class AddOutletIdToButtonClicks < ActiveRecord::Migration
  def change
    add_column :button_clicks, :outlet_id, :integer
  end
end
