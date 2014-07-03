class AddGcmRegistrationIdToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :gcm_registration_id, :string
  end
end
