class GcmNotification
    @queue = :gcm_queue
    def self.perform(gcm_arguments)
        GCM.host = 'https://android.googleapis.com/gcm/send'
        GCM.format = :json
        GCM.key = "AIzaSyBuletaXNhA4lTg3AfOkMsnEg998wMj2a4"

        @customer = Customer.find(gcm_arguments['customer_id'])
        GCM.send_notification(@customer.gcm_registration_id, gcm_arguments['data'])
        @native_notification = @customer.native_notifications.create(:ad_id => gcm_arguments['ad_id'])
        @customer.customer_locations.last.update_attributes(:native_notification_id => @native_notification.id)
    end
end
