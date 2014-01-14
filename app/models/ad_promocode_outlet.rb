class AdPromocodeOutlet < ActiveRecord::Base
  attr_accessible :ad_id, :ad_promocode_id, :outlet_id, :deleted_at
  belongs_to :ad
  belongs_to :ad_promocode
  belongs_to :outlet
  has_many :campaigns
  has_many :sms_sents
  has_paper_trail
  acts_as_paranoid

  after_create :generate_share_link
  after_create :add_ad

  def add_ad
  	self.ad_id = self.ad_promocode.ad.id
  	self.save
  end

  def generate_share_link
      ad = self.ad
      unless ad.nil?
          if ad.ad_promocode_outlets.nil?
              Campaign.generate_url(self)
          end
      end
  end
end
