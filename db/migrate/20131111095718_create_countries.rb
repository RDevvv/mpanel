class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :country_name
      t.string :iso_code
      t.integer :phone_country_code
      t.integer :currency_id
      t.string :currency_name

      t.timestamps
    end
  end
end
