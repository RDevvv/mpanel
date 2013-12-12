class AdVersion < ActiveRecord::Base
  attr_accessible :account_brand_id, :ad_id, :ad_title, :expiry_date, :is_active, :is_deleted, :is_friday, :is_monday, :is_saturday, :is_sunday, :is_thursday, :is_tuesday, :is_wednesday, :sms_text, :start_date, :lifetime_budget, :ad_sent, :ad_views, :ad_shares, :is_exclusive
  belongs_to :ad
end
