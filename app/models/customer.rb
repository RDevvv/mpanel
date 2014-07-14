class Customer < ActiveRecord::Base
  has_many :facebook_shares
  has_many :customer_sessions, :dependent => :destroy
  has_many :sms_sents
  has_many :call_forwardings
  has_many :button_clicks, :dependent => :destroy
  has_many :customer_feedbacks
  has_many :misc_smss
  has_many :customer_brand_scores
  has_many :ad_likes
  has_many :customer_keywords
  has_many :keywords, :through => :customer_keywords
  has_many :native_notifications
  has_many :customer_locations

  has_many :customer_campaign_copys
  has_many :campaign_copies, :through => :customer_campaign_copys

  attr_accessible :uuid, :mobile_number, :browser, :platform, :browser_version, :email_id, :name, :age, :gender
  attr_accessible :date_of_birth, :incentive_count, :verification_code, :is_verified, :subscribe_crm_updates, :gcm_registration_id
  attr_accessible :notification_enabled

  validates :mobile_number, :numericality => true,:length => {:minimum => 9, :maximum => 11}, :allow_blank => true
  validates :uuid, :presence => true, :uniqueness => true

  after_create :generate_verification_code


  def self.generate_cookie
    customer_uuid = nil
    while(customer_uuid == nil)
      customer_uuid = SecureRandom.uuid
      unless Customer.exists?(:uuid => customer_uuid)
        customer_uuid
      end
    end
    return customer_uuid
  end

  def generate_verification_code
      verification_code = 0
      while verification_code.to_s.length != 4
          verification_code = SecureRandom.random_number(9999)
      end
      self.update_attributes(:verification_code => verification_code)
  end
end
