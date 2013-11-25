class Ad < ActiveRecord::Base
  attr_accessible :ad_title, :ad_type, :account_brand_id, :daily_cap, :expiry_date, :is_active, :is_friday, :is_monday, :is_saturday, :is_sunday, :is_thursday, :is_tuesday, :is_wednesday, :latest_version_id, :lifetime_budget, :promocode_type_id, :sms_text, :start_date
  
  has_many :ad_keywords, :dependent => :destroy
  has_many :keywords, :through => :ad_keywords
  belongs_to :account_brand
  has_many :ad_versions
  has_many :ad_promocodes #,:dependent=>:destroy
  has_many :ad_promocode_outlets#,:dependent=>:destroy
  has_many :outlets,:through=>:ad_promocode_outlets
end
