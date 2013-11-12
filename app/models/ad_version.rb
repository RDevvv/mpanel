class AdVersion < ActiveRecord::Base
  attr_accessible :account_brand_id, :ad_id, :ad_title, :ad_type, :daily_cap, :expiry_date, :is_active, :is_deleted, :is_friday, :is_monday, :is_saturday, :is_sunday, :is_thursday, :is_tuesday, :is_wednesday, :lilfetime_budget, :promocode_type_id, :sms_text, :start_date, :version_id
end
