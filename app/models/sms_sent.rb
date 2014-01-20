class SmsSent < ActiveRecord::Base
    belongs_to :customer
    belongs_to :ad_promocode_outlet

    attr_accessible :text, :is_sent, :ad_promocode_outlet_id, :ad_promocode_outlet_version_id, :customer_id, :button_click_id

    validates :text, :presence => true
    validates :customer_id, :presence => true
    validates :ad_promocode_outlet_id, :presence => true
    validates :ad_promocode_outlet_version_id, :presence => true

    after_create :track_usage

    def track_usage
        ad = self.ad_promocode_outlet.ad
        ad.update_attributes(:usage => (ad.usage+1))
    end

    def message(number, message)
        message = Curl::Easy.new("https://gullakmaster:449df2572ff8b57017ceb975d5dc15b93d480e02@twilix.exotel.in/v1/Accounts/gullakmaster/Sms/send")
        message.ssl_verify_peer = false
        message.post(:From => "GULLAK", :To => number, :Body => message)
    end
end
