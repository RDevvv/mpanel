class ChangeDataTypeForFromAndToColumnsOfCallForwardings < ActiveRecord::Migration
  def up
  	change_column :call_forwardings, :from, :string
  	change_column :call_forwardings, :to, :string
  end

  def down
  	change_column :call_forwardings, :from, :integer
  	change_column :call_forwardings, :to, :integer
  end
end
