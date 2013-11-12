class AddRegisteredCompanyNameToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :registered_company_name, :string
  end
end
