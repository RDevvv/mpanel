class ChangePincodeTypeToPincodes < ActiveRecord::Migration
  def up
    change_column :pincodes, :pincode, :string
  end

  def down
  end
end
