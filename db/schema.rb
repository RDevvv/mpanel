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

ActiveRecord::Schema.define(:version => 20131128100310) do

  create_table "account_brands", :force => true do |t|
    t.integer  "brand_id"
    t.integer  "account_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "accounts", :force => true do |t|
    t.text     "address"
    t.integer  "area_id"
    t.string   "currency_id"
    t.string   "payment_status"
    t.float    "account_balance"
    t.string   "account_key"
    t.boolean  "is_active"
    t.boolean  "is_deleted"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "registered_company_name"
    t.boolean  "is_verified"
    t.integer  "pincode"
    t.string   "city"
  end

  create_table "ad_keywords", :force => true do |t|
    t.integer  "ad_id"
    t.integer  "keyword_id"
    t.boolean  "is_deleted"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ad_promocode_outlets", :force => true do |t|
    t.integer  "ad_id"
    t.integer  "outlet_id"
    t.integer  "ad_promocode_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "ad_promocodes", :force => true do |t|
    t.string   "set_name"
    t.string   "promocode"
    t.integer  "ad_id"
    t.float    "cap"
    t.float    "usage"
    t.boolean  "is_used",    :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "ad_versions", :force => true do |t|
    t.integer  "ad_id"
    t.integer  "version_id"
    t.integer  "account_brand_id"
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
    t.boolean  "is_deleted"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
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
    t.integer  "account_brand_id"
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
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.float    "lifetime_budget"
  end

  create_table "areas", :force => true do |t|
    t.integer  "city_id"
    t.string   "area_name"
    t.string   "pincode"
    t.string   "area_alias"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "attachments", :force => true do |t|
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "image"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "brands", :force => true do |t|
    t.string   "brand_name"
    t.string   "brand_alias"
    t.string   "brand_code"
    t.integer  "category_id"
    t.string   "website_url"
    t.boolean  "is_active"
    t.boolean  "is_verified"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "daily_cap"
  end

  create_table "categories", :force => true do |t|
    t.integer  "industry_id"
    t.string   "category_name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "cities", :force => true do |t|
    t.integer  "state_id"
    t.string   "city_name"
    t.integer  "metro_id"
    t.string   "time_zone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "countries", :force => true do |t|
    t.string   "country_name"
    t.string   "iso_code"
    t.integer  "phone_country_code"
    t.string   "currency_id"
    t.string   "currency_name"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "industries", :force => true do |t|
    t.string   "industry_name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "keyword_aliases", :force => true do |t|
    t.integer  "keyword_id"
    t.string   "alias_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "keywords", :force => true do |t|
    t.text     "keywords"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "metros", :force => true do |t|
    t.string   "metro_name"
    t.string   "metro_long_name"
    t.string   "metro_code"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "country_id"
  end

  create_table "outlet_types", :force => true do |t|
    t.string   "outlet_type_name"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "outlet_versions", :force => true do |t|
    t.integer  "outlet_id"
    t.integer  "version_id"
    t.integer  "account_brand_id"
    t.integer  "outlet_type_id"
    t.string   "outlet_name"
    t.string   "outlet_alias"
    t.text     "address"
    t.integer  "area_id"
    t.string   "phone_number"
    t.integer  "mobile_country_id"
    t.string   "mobile_number"
    t.integer  "payment_value_id"
    t.string   "email_id"
    t.boolean  "is_active"
    t.boolean  "is_verified"
    t.string   "outlet_key"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "daily_cap"
    t.boolean  "is_deleted"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "outlets", :force => true do |t|
    t.integer  "latest_version_id"
    t.integer  "account_brand_id"
    t.integer  "outlet_type_id"
    t.string   "outlet_name"
    t.string   "outlet_alias"
    t.text     "address"
    t.integer  "area_id"
    t.string   "phone_number"
    t.integer  "mobile_country_id"
    t.string   "mobile_number"
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

  create_table "payment_values", :force => true do |t|
    t.float    "catchment_radius"
    t.string   "currency_id"
    t.float    "value"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "promocode_types", :force => true do |t|
    t.string   "promocode_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
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

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "states", :force => true do |t|
    t.string   "state_name"
    t.string   "state_code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "country_id"
  end

  create_table "user_accounts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_brand_accounts", :force => true do |t|
    t.integer  "user_account_id"
    t.integer  "account_brand_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "is_deleted"
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
    t.string   "first_name"
    t.string   "last_name"
    t.string   "mobile_country_id"
    t.string   "mobile_number"
    t.string   "user_key"
    t.boolean  "is_active"
    t.boolean  "email_verified"
    t.boolean  "mobile_verified"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
