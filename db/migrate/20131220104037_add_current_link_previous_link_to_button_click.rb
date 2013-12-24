class AddCurrentLinkPreviousLinkToButtonClick < ActiveRecord::Migration
  def change
    add_column :button_clicks, :current_link, :string
    add_column :button_clicks, :previous_link, :string
    add_column :button_clicks, :session_id, :string
  end
end
