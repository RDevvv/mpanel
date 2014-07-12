class CampaignCopy < ActiveRecord::Base
    belongs_to :campaign
    belongs_to :customer
    has_many :customer_campaign_copys

    attr_accessible :copy_sent, :expires_at, :is_delivered, :is_opened, :is_sent, :use_count, :short_url, :vendor_id, :customer_id, :post_expiry_forward_url, :pre_expiry_forward_url
    after_create :create_short_url
    after_create :update_campaign

    def create_short_url
        short_url = SecureRandom.urlsafe_base64(3)
        self.update_attributes(:short_url => short_url)
    end

    def update_campaign
      if self.campaign.use_count.nil?
          self.campaign.update_attributes(:use_count => 1)
      else
          self.campaign.update_attributes(:use_count => campaign.use_count+1)
      end
    end
end
