class AddSubscribeCrmUpdatesToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :subscribe_crm_updates, :boolean, default: true
  end
end
