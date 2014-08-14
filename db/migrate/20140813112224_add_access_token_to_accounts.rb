class AddAccessTokenToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :facebook_access_token, :string
  end
end
