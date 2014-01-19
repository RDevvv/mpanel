class RenameSessionIdInButtonClicksToCustomerSessionId < ActiveRecord::Migration
  def up
      rename_column :button_clicks, :session_id, :customer_session_id
  end

  def down
  end
end
