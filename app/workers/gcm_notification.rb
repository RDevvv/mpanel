class GcmNotification
    @queue = :gcm_queue
    def self.perform(gcm_arguments)
        GCM.host = 'https://android.googleapis.com/gcm/send'
        GCM.format = :json
        GCM.key = "AIzaSyBuletaXNhA4lTg3AfOkMsnEg998wMj2a4"

        GCM.send_notification( gcm_arguments[0], gcm_arguments[1])
        @customer = Customer.find(gcm_arguments[2])
        @native_notification = @customer.native_notifications.create(:ad_id => gcm_arguments[3])
        @customer.customer_locations.last.update_attributes(:native_notification_id => @native_notification.id)
    end
end
