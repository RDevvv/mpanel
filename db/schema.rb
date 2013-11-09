# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131109110103) do

  create_table "account_brands", :force => true do |t|
    t.integer  "brand_id"
    t.integer  "account_id"
    t.boolean  "is_active"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "user_acount_ids"
  end

  create_table "accounts", :force => true do |t|
    t.text     "address_line1"
    t.text     "address_line2"
    t.integer  "area_id"
    t.integer  "city_id"
    t.integer  "pincode"
    t.integer  "currency_id"
    t.string   "payment_status"
    t.float    "account_balance"
    t.integer  "account_key"
    t.boolean  "is_active"
    t.integer  "admin_user_id"
    t.boolean  "is_deleted"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "user_id"
    t.integer  "brand_ids"
    t.integer  "user_ids"
  end

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "ads", :force => true do |t|
    t.integer  "latest_version_id"
    t.integer  "brand_account_id"
    t.string   "ad_type"
    t.string   "ad_title"
    t.boolean  "is_monday"
    t.boolean  "is_tuesday"
    t.boolean  "is_wednesday"
    t.boolean  "is_thursday"
    t.boolean  "is_friday"
    t.boolean  "is_saturday"
    t.boolean  "is_sunday"
    t.datetime "start_date"
    t.datetime "expiry_date"
    t.boolean  "is_active"
    t.text     "sms_text"
    t.integer  "promocode_type_id"
    t.string   "daily_cap"
    t.float    "lilfetime_budget"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "areas", :force => true do |t|
    t.integer  "city_id"
    t.string   "area_name"
    t.integer  "pincode"
    t.string   "area_alias"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "brands", :force => true do |t|
    t.integer  "brand_id"
    t.string   "brand_name"
    t.string   "brand_alias"
    t.string   "brand_code"
    t.integer  "category_id"
    t.string   "website_url"
    t.boolean  "is_active"
    t.boolean  "is_verified"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "account_ids"
  end

  create_table "keywords", :force => true do |t|
    t.text     "keywords"
    t.integer  "ad_ids"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "outlets", :force => true do |t|
    t.integer  "latest_version_id"
    t.integer  "account_brand_id"
    t.integer  "outlet_type_id"
    t.string   "outlet_name"
    t.string   "outlet_alias"
    t.text     "address"
    t.integer  "area_id"
    t.integer  "phone_number"
    t.integer  "mobile_country_id"
    t.integer  "mobile_number"
    t.integer  "payment_value_id"
    t.string   "email_id"
    t.boolean  "is_active"
    t.boolean  "is_verified"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "daily_cap"
    t.string   "outlet_key"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "user_accounts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "account_brand_ids"
  end

  create_table "user_brand_accounts", :force => true do |t|
    t.integer  "user_account_id"
    t.integer  "account_brand_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "account_ids"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
