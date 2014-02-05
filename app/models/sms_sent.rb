class SmsSent < ActiveRecord::Base
    belongs_to :customer
    belongs_to :ad_promocode_outlet

    attr_accessible :text, :is_sent, :ad_promocode_outlet_id, :ad_promocode_outlet_version_id, :customer_id, :button_click_id, :vendor_id

    validates :text, :presence => true
    validates :customer_id, :presence => true
    validates :ad_promocode_outlet_id, :presence => true
    validates :ad_promocode_outlet_version_id, :presence => true

    after_create :track_usage
    after_create :send_message

    def track_usage
        ad = self.ad_promocode_outlet.ad
        ad.update_attributes(:usage => (ad.usage+1))
    end

    def message(number, message)
        message = Curl::Easy.new("https://gullakmaster:449df2572ff8b57017ceb975d5dc15b93d480e02@twilix.exotel.in/v1/Accounts/gullakmaster/Sms/send")
        message.ssl_verify_peer = false
        message.post(:From => "GULLAK", :To => number, :Body => message)
    end


    def send_text_message
        twilio_sid = "gullakmaster"
        twilio_token = "449df2572ff8b57017ceb975d5dc15b93d480e02"
        twilio_phone_number = "08080156677"

        @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

        @twilio_client.account.sms.messages.create(
            :from => "91#{twilio_phone_number}",
            :to => 9405514310,
            :body => "This is an message. It gets sent to "
        )
    end

    def send_message
        Exotel.configure do |c|
            c.exotel_sid   = "gullakmaster"
            c.exotel_token = "449df2572ff8b57017ceb975d5dc15b93d480e02"
        end

        response = Exotel::Sms.send(:from => '09223584822', :to => self.get_number, :body => self.text)
        self.update_attributes(:vendor_id => response.sid)
    end

    def get_number
        self.customer.mobile_number
    end
end
