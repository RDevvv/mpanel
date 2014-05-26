class ExotelSms
    @queue = :sms_queue
    def self.perform(sms_sent_id)
        Exotel.configure do |c|
            c.exotel_sid   = "gullakmaster"
            c.exotel_token = "449df2572ff8b57017ceb975d5dc15b93d480e02"
        end

        sms_sent = SmsSent.find(sms_sent_id)
        sms_text = sms_sent.text.gsub('<b>','').gsub('</b>','').gsub('<br />','')
        response = Exotel::Sms.send(:from => '08767451515', :to => sms_sent.get_number, :body => sms_text)
        sms_sent.update_attributes(:vendor_id => response.sid)
    end
end
