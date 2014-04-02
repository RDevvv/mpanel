class Customer < ActiveRecord::Base
  has_many :facebook_shares
  has_many :customer_sessions, :dependent => :destroy
  has_many :sms_sents
  has_many :call_forwardings
  has_many :button_clicks, :dependent => :destroy
  has_many :customer_feedbacks
  has_one :customer_brand_score

  attr_accessible :uuid, :mobile_number, :browser, :platform, :browser_version, :email_id, :name, :age, :gender
  attr_accessible :date_of_birth, :incentive_count, :verification_code, :is_verified, :subscribe_crm_updates

  validates :mobile_number, :numericality => true,:length => {:minimum => 9, :maximum => 11}, :allow_blank => true
  validates :uuid, :presence => true

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
    self.update_attributes(:verification_code => SecureRandom.random_number(9999))
    text = "Your verification code is : #{self.verification_code} Thanks, GullakMaster"
    self.sms_sents.create(:text => text)
  end
end
