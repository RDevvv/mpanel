class AddPincodeToAreas < ActiveRecord::Migration
  def change
    add_column :areas, :pincode, :string
    
  end
end
