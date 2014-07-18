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
        @customer = Customer.where(:uuid => params[:customer_uuid]).first
        @customer.customer_locations.create(:latitude => params[:latitude], :longitude => params[:longitude])
        @notification_ad = Ad.new

        @outlets  = Outlet.new(:latitude => params[:latitude], :longitude => params[:longitude]).nearbys(1, :units => :km)
        @ads = @outlets.map{|outlet|outlet.ads}.flatten
        @final_ads = Ad.get_nearest_ad(@ads,@keyword_ads)
        @keyword_ads = @customer.keywords.map{|keyword|keyword.ads}.flatten

        @notifications_sent = @customer.native_notifications.map{|notification|notification.ad_id}
        @final_ads = @final_ads-@notifications_sent

        unless @final_ads.blank?
            @notification_ad = Ad.find(@final_ads.first)
            destination = [@customer.gcm_registration_id]
            brand_name = @notification_ad.account_brand.brand.brand_name
            data = {:message => brand_name+' - '+@notification_ad.sms_text, :msgcnt => "1", :soundname => "beep.wav"}
            @location_changed_flag = @customer.check_if_location_changed_significantly(params[:latitude], params[:longitude])

            if (NativeNotification.check_if_within_timeframe)&&(@location_changed_flag>1)
                Resque.enqueue(GcmNotification,[destination,data,@customer.id,@notification_ad.id])
            end
        end

        render :json => {:vivek => 'ok'}#{:notification_text => @ad.sms_text}
    end
end
