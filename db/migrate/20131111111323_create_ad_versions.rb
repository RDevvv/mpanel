class CreateAdVersions < ActiveRecord::Migration
  def change
    create_table :ad_versions do |t|
      t.integer :ad_id
      t.integer :version_id
      t.integer :account_brand_id
      t.string :ad_type
      t.string :ad_title
      t.boolean :is_monday
      t.boolean :is_tuesday
      t.boolean :is_wednesday
      t.boolean :is_thursday
      t.boolean :is_friday
      t.boolean :is_saturday
      t.boolean :is_sunday
      t.datetime :start_date
      t.datetime :expiry_date
      t.boolean :is_active
      t.text :sms_text
      t.integer :promocode_type_id
      t.string :daily_cap
      t.float :lilfetime_budget
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
