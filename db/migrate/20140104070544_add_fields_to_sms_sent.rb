class AddFieldsToSmsSent < ActiveRecord::Migration
  def change
    add_column :sms_sents, :button_click_id, :integer
    add_column :sms_sents, :ad_promocode_outlet_id, :integer
    add_column :sms_sents, :ad_promocode_outlet_version_id, :integer
  end
end
