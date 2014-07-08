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
        @keyword_ads = @customer.keywords.map{|keyword|keyword.ads}.flatten
        @outlets  = Outlet.new(:latitude => params[:latitude], :longitude => params[:longitude]).nearbys(50, :units => :km)
        @ads = @outlets.map{|outlet|outlet.ads}.flatten
        @final_ads = Ad.get_nearest_ad(@ads,@keyword_ads)
        @notification_ad = Ad.find(@final_ads.first)

        destination = [@customer.gcm_registration_id]
        brand_name = @notification_ad.account_brand.brand.brand_name
        data = {:message => brand_name+' - '+@notification_ad.sms_text, :msgcnt => "1", :soundname => "beep.wav"}

        GCM.send_notification( destination, data)

        render :json => {:vivek => 'vivek'}#{:notification_text => @ad.sms_text}
    end
end
