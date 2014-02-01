class AddVendorIdToSmsSent < ActiveRecord::Migration
  def change
    add_column :sms_sents, :vendor_id, :string
  end
end
