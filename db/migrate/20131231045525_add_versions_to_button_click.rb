class AddVersionsToButtonClick < ActiveRecord::Migration
  def change
    add_column :button_clicks, :outlet_version_id, :integer
    add_column :button_clicks, :ad_version_id, :integer
  end
end
