class ChangeDataTypeOfAdsStartDateDatetimeToDate < ActiveRecord::Migration
  def up
  	change_column :ads, :start_date, :date
  end

  def down
  	change_column :ads, :start_date, :datetime
  end
end
