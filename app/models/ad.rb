class Ad < ActiveRecord::Base
  attr_accessible :ad_title, :account_brand_id, :expiry_date, :is_active, :is_friday, :is_monday, :is_saturday, :is_sunday, :is_thursday, :is_tuesday, :is_wednesday, :sms_text, :start_date, :is_exclusive
  attr_accessible :keyword_ids,:attachments_attributes
  has_many :ad_keywords, :dependent => :destroy
  has_many :keywords, :through => :ad_keywords
  belongs_to :account_brand
  has_many :ad_versions
  has_many :ad_promocodes #,:dependent=>:destroy
  has_many :ad_promocode_outlets#,:dependent=>:destroy
  has_many :outlets,:through=>:ad_promocode_outlets
  has_many :ad_groups, :dependent => :destroy
  has_many :facebook_shares
  
  has_many :attachments, :as => :attachable ,:class_name=>'Attachment'
  accepts_nested_attributes_for :attachments ,allow_destroy: true
  has_paper_trail
  
  scope :expire_ads,lambda{where("expiry_date is not null and expiry_date < ?",Date.today)}
  scope :active_ads,lambda{where("expiry_date is  null or expiry_date >= ?",Date.today)}
end
