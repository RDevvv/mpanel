class AddDetailsToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :mobile_number, :integer, :limit => 8
    add_column :customers, :name, :string
    add_column :customers, :email_id, :string
    add_column :customers, :date_of_birth, :datetime
    add_column :customers, :age, :integer
    add_column :customers, :gender, :string
    add_column :customers, :incentive_count, :integer
  end
end
