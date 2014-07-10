class NativeNotificationsController < ApplicationController
    def fetch_gcm_id
        @customer = Customer.where(:uuid => params[:customer_uuid]).first
        @gcm_registration_id = @customer.gcm_registration_id unless @customer.nil?
        render :json => {:gcm_registration_id => @gcm_registration_id}
    end

    def set_gcm_id
        Customer.where(:uuid => params[:customer_uuid]).first.update_attributes(:gcm_registration_id => params[:gcm_registration_id])
        render :json => {:gcm_registration_id => 'asdf'}
    end

    def get_customer_coordinates
        GCM.host = 'https://android.googleapis.com/gcm/send'
        GCM.format = :json
        GCM.key = "AIzaSyBuletaXNhA4lTg3AfOkMsnEg998wMj2a4"

        @customer = Customer.where(:uuid => params[:customer_uuid]).first
        @customer.customer_locations.create(:latitude => params[:latitude], :longitude => params[:longitude])
        @notification_ad = Ad.new

        @keyword_ads = @customer.keywords.map{|keyword|keyword.ads}.flatten
        @outlets  = Outlet.new(:latitude => params[:latitude], :longitude => params[:longitude]).nearbys(1, :units => :km)
        @ads = @outlets.map{|outlet|outlet.ads}.flatten
        @final_ads = Ad.get_nearest_ad(@ads,@keyword_ads)
        binding.pry
        unless @final_ads.blank?
            @notification_ad = Ad.find(@final_ads.first)
            destination = [@customer.gcm_registration_id]
            brand_name = @notification_ad.account_brand.brand.brand_name
            data = {:message => brand_name+' - '+@notification_ad.sms_text, :msgcnt => "1", :soundname => "beep.wav"}

            upper_limit = Time.now.change(:hour => 7)
            lower_limit = Time.now.change(:hour => 22)
            if((Time.now>upper_limit)&&(Time.now.<lower_limit))
                @similar_notification = NativeNotification.where(:ad_id => @notification_ad.id, :customer_id => @customer.id)
                unless(@similar_notification.exists?)
                    GCM.send_notification( destination, data)
                    @customer.native_notifications.create(:ad_id => @notification_ad.id)
                end
            end
        end

        render :json => {:vivek => 'vivek'}#{:notification_text => @ad.sms_text}
    end
end
