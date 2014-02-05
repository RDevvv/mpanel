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

ActiveRecord::Schema.define(:version => 20140131090438) do

  create_table "account_brands", :force => true do |t|
    t.integer  "brand_id"
    t.integer  "account_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.time     "deleted_at"
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
    t.time     "deleted_at"
  end

  create_table "ad_groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "ad_id"
    t.boolean  "is_multiple", :default => false
    t.time     "deleted_at"
  end

  create_table "ad_keywords", :force => true do |t|
    t.integer  "ad_id"
    t.integer  "keyword_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.time     "deleted_at"
  end

  create_table "ad_promocode_outlets", :force => true do |t|
    t.integer  "ad_id"
    t.integer  "outlet_id"
    t.integer  "ad_promocode_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.time     "deleted_at"
  end

  create_table "ad_promocodes", :force => true do |t|
    t.string   "promocode"
    t.integer  "ad_id"
    t.float    "cap"
    t.float    "usage",       :default => 0.0
    t.boolean  "is_used",     :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "is_active",   :default => true
    t.integer  "ad_group_id"
    t.time     "deleted_at"
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
    t.integer  "account_brand_id"
    t.string   "ad_title"
    t.boolean  "is_monday",        :default => false
    t.boolean  "is_tuesday",       :default => false
    t.boolean  "is_wednesday",     :default => false
    t.boolean  "is_thursday",      :default => false
    t.boolean  "is_friday",        :default => false
    t.boolean  "is_saturday",      :default => false
    t.boolean  "is_sunday",        :default => false
    t.date     "start_date"
    t.date     "expiry_date"
    t.boolean  "is_active",        :default => true
    t.text     "sms_text"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.boolean  "is_exclusive",     :default => false
    t.time     "deleted_at"
    t.integer  "usage",            :default => 0
  end

  create_table "areas", :force => true do |t|
    t.integer  "city_id"
    t.string   "area_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "pincode"
  end

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.string   "body"
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

  create_table "brand_sessions", :force => true do |t|
    t.integer  "brand_id"
    t.integer  "customer_session_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "brand_sessions", ["brand_id"], :name => "index_brand_sessions_on_brand_id"
  add_index "brand_sessions", ["customer_session_id"], :name => "index_brand_sessions_on_customer_session_id"

  create_table "brands", :force => true do |t|
    t.string   "brand_name"
    t.integer  "category_id"
    t.string   "website_url"
    t.boolean  "is_active"
    t.boolean  "is_verified"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "button_clicks", :force => true do |t|
    t.integer  "customer_id"
    t.string   "button_class"
    t.integer  "ad_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "current_link"
    t.string   "previous_link"
    t.string   "customer_session_id"
    t.integer  "outlet_id"
    t.integer  "outlet_version_id"
    t.integer  "ad_version_id"
  end

  add_index "button_clicks", ["customer_id"], :name => "index_button_clicks_on_customer_id"

  create_table "call_button_selects", :force => true do |t|
    t.integer  "customer_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "call_button_selects", ["customer_id"], :name => "index_call_button_selects_on_customer_id"

  create_table "call_forwardings", :force => true do |t|
    t.integer  "outlet_id"
    t.integer  "customer_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "call_sid"
    t.string   "from"
    t.string   "to"
    t.string   "direction"
    t.time     "dial_call_duration"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "call_type"
    t.string   "digits"
    t.string   "recording_url"
    t.integer  "session_id"
    t.integer  "ad_id"
  end

  add_index "call_forwardings", ["customer_id"], :name => "index_call_forwardings_on_customer_id"
  add_index "call_forwardings", ["outlet_id"], :name => "index_call_forwardings_on_outlet_id"

  create_table "campaign_copies", :force => true do |t|
    t.integer  "campaign_id"
    t.datetime "expires_at"
    t.boolean  "is_sent",      :default => false
    t.boolean  "is_delivered", :default => false
    t.boolean  "is_opened",    :default => false
    t.integer  "customer_id"
    t.integer  "copy_sent"
    t.integer  "use_count"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "vendor_id"
    t.string   "short_url"
  end

  add_index "campaign_copies", ["campaign_id"], :name => "index_campaign_copies_on_campaign_id"
  add_index "campaign_copies", ["customer_id"], :name => "index_campaign_copies_on_customer_id"

  create_table "campaigns", :force => true do |t|
    t.string   "source"
    t.string   "medium"
    t.string   "marketer"
    t.string   "campaign_type"
    t.string   "keyword"
    t.string   "pre_expiry_forward_url"
    t.string   "post_expiry_forward_url"
    t.string   "short_url"
    t.string   "unique_key"
    t.datetime "expires_at"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "ad_promocode_outlet_id"
    t.string   "campaign_template"
    t.string   "purpose"
    t.string   "placement"
    t.string   "target"
    t.string   "campaign_name"
  end

  create_table "categories", :force => true do |t|
    t.integer  "industry_id"
    t.string   "category_name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "cities", :force => true do |t|
    t.string   "city_name"
    t.string   "time_zone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "country_id"
  end

  create_table "comments", :force => true do |t|
    t.string   "title"
    t.string   "body"
    t.integer  "article_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
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

  create_table "customer_sessions", :force => true do |t|
    t.integer  "customer_id"
    t.string   "browser"
    t.string   "platform"
    t.string   "browser_version"
    t.string   "referer_link"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.float    "longitude"
    t.float    "latitude"
    t.string   "campaign_url"
  end

  add_index "customer_sessions", ["customer_id"], :name => "index_customer_sessions_on_customer_id"

  create_table "customers", :force => true do |t|
    t.string   "uuid"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.integer  "mobile_number",         :limit => 8
    t.string   "name"
    t.string   "email_id"
    t.datetime "date_of_birth"
    t.integer  "age"
    t.string   "gender"
    t.integer  "incentive_count"
    t.boolean  "is_verified"
    t.string   "verification_code"
    t.boolean  "subscribe_crm_updates",              :default => true
  end

  create_table "facebook_shares", :force => true do |t|
    t.integer  "ad_id"
    t.integer  "customer_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "facebook_shares", ["ad_id"], :name => "index_facebook_shares_on_ad_id"
  add_index "facebook_shares", ["customer_id"], :name => "index_facebook_shares_on_customer_id"

  create_table "incentives", :force => true do |t|
    t.string   "name"
    t.string   "sms_text"
    t.datetime "expiry_date"
    t.boolean  "is_active"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "industries", :force => true do |t|
    t.string   "industry_name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "keywords", :force => true do |t|
    t.text     "keyword"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "keyword_alias"
  end

  create_table "leads", :force => true do |t|
    t.string   "source"
    t.string   "email"
    t.integer  "mobile_number",           :limit => 8
    t.string   "first_name"
    t.string   "last_name"
    t.string   "target"
    t.string   "company_name"
    t.string   "designation"
    t.boolean  "subscribe_email_updates"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "location_caches", :force => true do |t|
    t.float    "longitude"
    t.float    "latitude"
    t.string   "location"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "missed_calls", :force => true do |t|
    t.integer  "campaign_id"
    t.string   "call_sid"
    t.string   "from"
    t.string   "to"
    t.boolean  "is_valid"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "missed_calls", ["campaign_id"], :name => "index_missed_calls_on_campaign_id"

  create_table "mobile_verification_codes", :force => true do |t|
    t.string   "verification_code"
    t.integer  "customer_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "mobile_verification_codes", ["customer_id"], :name => "index_mobile_verification_codes_on_customer_id"

  create_table "nested_comments", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "comment_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "outlets", :force => true do |t|
    t.integer  "account_brand_id"
    t.text     "address"
    t.integer  "area_id"
    t.string   "phone_number"
    t.string   "mobile_number"
    t.string   "email_id"
    t.boolean  "is_active",        :default => false
    t.boolean  "is_verified",      :default => false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "outlet_key"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.time     "deleted_at"
    t.string   "shop_no"
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

  create_table "sms_sents", :force => true do |t|
    t.string   "text"
    t.integer  "is_sent"
    t.integer  "customer_id"
    t.integer  "ad_promocode_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "button_click_id"
    t.integer  "ad_promocode_outlet_id"
    t.integer  "ad_promocode_outlet_version_id"
    t.string   "vendor_id"
  end

  add_index "sms_sents", ["ad_promocode_id"], :name => "index_sms_sents_on_ad_promocode_id"
  add_index "sms_sents", ["customer_id"], :name => "index_sms_sents_on_customer_id"

  create_table "user_accounts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.time     "deleted_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                   :default => "",   :null => false
    t.string   "encrypted_password",      :default => "",   :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           :default => 0,    :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
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
    t.boolean  "subscribe_email_updates", :default => true
    t.boolean  "subscribe_crm_updates",   :default => true
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "versions", :force => true do |t|
    t.string   "item_type",      :null => false
    t.integer  "item_id",        :null => false
    t.string   "event",          :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
