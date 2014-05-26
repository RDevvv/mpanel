class ExotelMiscSms
    @queue = :sms_queue
    def self.perform(sms_id)
        Exotel.configure do |c|
            c.exotel_sid   = "gullakmaster"
            c.exotel_token = "449df2572ff8b57017ceb975d5dc15b93d480e02"
        end

        misc_sms = MiscSms.find(sms_id)
        response = Exotel::Sms.send(:from => '08767451515', :to => misc_sms.get_number, :body => misc_sms.text)
        misc_sms.update_attributes(:vendor_id => response.sid)
    end
end

