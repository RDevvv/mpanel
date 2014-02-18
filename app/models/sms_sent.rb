class SmsSent < ActiveRecord::Base
    belongs_to :customer, :dependent => :destroy
    belongs_to :ad_promocode_outlet

    attr_accessible :text, :is_sent, :ad_promocode_outlet_id, :ad_promocode_outlet_version_id, :customer_id, :button_click_id, :vendor_id

    validates :text, :presence => true
    validates :customer_id, :presence => true
    validates :ad_promocode_outlet_id, :presence => true
    validates :ad_promocode_outlet_version_id, :presence => true

    after_create :track_usage
    after_create :send_message

    def track_usage
        unless self.ad_promocode_outlet.blank?
            ad = self.ad_promocode_outlet.ad
            ad.update_attributes(:usage => (ad.usage+1))
        end
    end

    def send_message
        Resque.enqueue(ExotelSms,self.id)
    end

    def get_number
        self.customer.mobile_number
    end
end
