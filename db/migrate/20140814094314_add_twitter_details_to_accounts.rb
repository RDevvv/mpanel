class AddTwitterDetailsToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :twitter_api_key, :string
    add_column :accounts, :twitter_api_secret, :string
    add_column :accounts, :twitter_access_token, :string
    add_column :accounts, :twitter_access_token_secret, :string
  end
end
