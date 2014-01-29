class Ad < ActiveRecord::Base
  attr_accessible :ad_title, :account_brand_id, :expiry_date, :is_active, :is_friday, :is_monday, :is_saturday, :is_sunday, :is_thursday, :is_tuesday, :is_wednesday, :sms_text, :start_date, :is_exclusive
  attr_accessible :keyword_ids,:attachments_attributes, :deleted_at, :usage
  has_many :ad_keywords, :dependent => :destroy
  has_many :keywords, :through => :ad_keywords
  belongs_to :account_brand
  has_many :ad_promocodes ,:dependent=>:destroy
  has_many :ad_promocode_outlets,:dependent=>:destroy
  has_many :outlets,:through=>:ad_promocode_outlets
  has_many :ad_groups, :dependent => :destroy
  
  has_many :facebook_shares
  has_many :button_clicks

  after_create :brand_name_keyword
  
  has_many :attachments, :as => :attachable ,:class_name=>'Attachment'
  accepts_nested_attributes_for :attachments ,allow_destroy: true
  has_paper_trail
  acts_as_paranoid
  
  scope :expire_ads,lambda{where("expiry_date is not null and expiry_date < ?",Date.today)}
  scope :active_ads,lambda{where("expiry_date is  null or expiry_date >= ?",Date.today)}

  def brand_name_keyword
      brand_name = self.account_brand.brand.brand_name
      keywords = Keyword.where(:keyword => brand_name)
      if keywords.empty?
          keyword = Keyword.create(:keyword => brand_name)
          keyword.ad_keywords.create(:ad_id => self.id)
          brand_name.split(" ").each do |word|
              new_keyword = Keyword.create(:keyword => word)
              new_keyword.ad_keywords.create(:ad_id => self.id)
          end
      else
          keywords.first.ad_keywords.create(:ad_id => self.id)
          brand_name.split(" ").each do |word|
              Keyword.where(:keyword => word).first.ad_keywords.create(:ad_id => self.id)
          end
      end
  end

  def toggle_active
      self.is_active? ?  self.deactivate : self.activate
  end

  def activate
      self.is_active = true
      self.save
  end

  def deactivate
      self.is_active = false
      self.save
  end

  def toggle_exclusive
      self.is_exclusive? ?  self.deactivate_exclusive : self.activate_exclusive
  end

  def activate_exclusive
      self.is_exclusive = true
      self.save
  end

  def deactivate_exclusive
      self.is_exclusive = false
      self.save
  end

  def expired?
      self.expiry_date.present? && self.expiry_date < Date.today
  end
end
