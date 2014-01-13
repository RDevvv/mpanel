class AddSessionIdToCallForwardings < ActiveRecord::Migration
  def change
    add_column :call_forwardings, :session_id, :integer
    add_column :call_forwardings, :ad_id, :integer
  end
end
