class Ad < ActiveRecord::Base
  attr_accessible :ad_title, :ad_type, :brand_account_id, :daily_cap, :expiry_date, :is_active, :is_friday, :is_monday, :is_saturday, :is_sunday, :is_thursday, :is_tuesday, :is_wednesday, :latest_version_id, :lilfetime_budget, :promocode_type_id, :sms_text, :start_date
end
