class CreateOutletVersions < ActiveRecord::Migration
  def change
    create_table :outlet_versions do |t|
      t.integer :outlet_id
      t.integer :version_id
      t.integer :brand_account_id
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
      t.string :outlet_key
      t.float :latitude
      t.float :longitude
      t.string :daily_cap
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
