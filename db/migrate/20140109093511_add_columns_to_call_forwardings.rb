class AddColumnsToCallForwardings < ActiveRecord::Migration
  def change
    add_column :call_forwardings, :call_sid, :string
    add_column :call_forwardings, :from, :integer
    add_column :call_forwardings, :to, :integer
    add_column :call_forwardings, :direction, :string
    add_column :call_forwardings, :dial_call_duration, :time
    add_column :call_forwardings, :start_time, :datetime
    add_column :call_forwardings, :end_time, :datetime
    add_column :call_forwardings, :call_type, :string
    add_column :call_forwardings, :digits, :string
    add_column :call_forwardings, :recording_url, :string
  end
end
