class Ad < ActiveRecord::Base
  attr_accessible :ad_title, :account_brand_id, :expiry_date, :is_active, :is_friday, :is_monday, :is_saturday, :is_sunday, :is_thursday, :is_tuesday, :is_wednesday, :latest_version_id, :sms_text, :start_date, :ad_sent, :ad_views, :ad_shares, :is_exclusive
  attr_accessible :keyword_ids
  has_many :ad_keywords, :dependent => :destroy
  has_many :keywords, :through => :ad_keywords
  belongs_to :account_brand
  has_many :ad_versions
  has_many :ad_promocodes #,:dependent=>:destroy
  has_many :ad_promocode_outlets#,:dependent=>:destroy
  has_many :outlets,:through=>:ad_promocode_outlets
  has_many :attachments, :as => :attachable ,:class_name=>'Attachment'
  accepts_nested_attributes_for :ad_keywords
end
