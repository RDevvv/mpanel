class AddPincodeAndCityToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :pincode, :integer
    add_column :accounts, :city, :string
  end
end
