class ChangeDataTypeOfAdsExpiryTabDatetimeToDate < ActiveRecord::Migration
  def up
  	change_column :ads, :expiry_date, :date
  end

  def down
  	change_column :ads, :expiry_date, :datetime
  end
end
