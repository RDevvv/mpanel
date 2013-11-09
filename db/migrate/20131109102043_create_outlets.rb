class CreateOutlets < ActiveRecord::Migration
  def change
    create_table :outlets do |t|
      t.integer :latest_version_id
      t.integer :account_brand_id
      t.integer :outlet_type_id
      t.string :outlet_name
      t.string :outlet_alias
      t.text :address
      t.integer :area_id
      t.integer :phone_number
      t.integer :mobile_country_id
      t.integer :mobile_number
      t.integer :payment_value_id
      t.string :email_id
      t.boolean :is_active
      t.boolean :is_verified
      t.float :latitude
      t.float :longitude
      t.string :daily_cap
      t.string :outlet_key

      t.timestamps
    end
  end
end
