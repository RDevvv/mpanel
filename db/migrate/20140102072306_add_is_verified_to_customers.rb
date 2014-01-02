class AddIsVerifiedToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :is_verified, :boolean
    add_column :customers, :verification_code, :string
    change_column :customers, :mobile_number, :integer, :limit => 8

  end
end
