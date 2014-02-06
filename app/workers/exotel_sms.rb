class ExotelSms
    @queue = :sms_queue
    def self.perform(sms_sent_id)
        Exotel.configure do |c|
            c.exotel_sid   = "gullakmaster"
            c.exotel_token = "449df2572ff8b57017ceb975d5dc15b93d480e02"
        end

        sms_sent = SmsSent.find(sms_sent_id)
        response = Exotel::Sms.send(:from => '09223584822', :to => sms_sent.get_number, :body => sms_sent.text)
        sms_sent.update_attributes(:vendor_id => response.sid)
    end
end
