class AddDailyCapColumnToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :daily_cap, :string
  end
end
