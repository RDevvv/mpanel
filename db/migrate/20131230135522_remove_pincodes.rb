class RemovePincodes < ActiveRecord::Migration
  def up
    drop_table :pincodes if ActiveRecord::Base.connection.table_exists? 'pincodes'
    # remove_column :accounts,:pincode
    remove_column :accounts,:pincode_id
    remove_column :outlets,:pincode_id
    # remove_column :outlets,:pincode
  end

  def down
  end
end
