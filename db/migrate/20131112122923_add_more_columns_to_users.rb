class AddMoreColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :mobile_country_id, :string
    add_column :users, :mobile_number, :integer
    add_column :users, :user_key, :string
    add_column :users, :is_active, :boolean
    add_column :users, :email_verified, :boolean
    add_column :users, :mobile_verified, :boolean
  end
end
