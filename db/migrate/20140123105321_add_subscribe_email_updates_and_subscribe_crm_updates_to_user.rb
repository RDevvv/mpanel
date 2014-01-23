class AddSubscribeEmailUpdatesAndSubscribeCrmUpdatesToUser < ActiveRecord::Migration
  def change
    add_column :users, :subscribe_email_updates, :boolean, default: true
    add_column :users, :subscribe_crm_updates, :boolean, default: true
  end
end
