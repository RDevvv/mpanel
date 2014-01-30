class CampaignCopy < ActiveRecord::Base
    belongs_to :campaign
    belongs_to :customer
    attr_accessible :copy_sent, :expires_at, :is_delivered, :is_opened, :is_sent, :use_count, :short_url, :vendor_id, :customer_id
    after_create :create_short_url

    def create_short_url
        short_url = SecureRandom.urlsafe_base64(3)
        self.update_attributes(:short_url => short_url)
    end
end
