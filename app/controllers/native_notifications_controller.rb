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
        @outlets  = Outlet.new(:latitude => params[:latitude], :longitude => params[:longitude]).nearbys(1, :units => :km)
        @ad = Ad.get_nearest_ad(@outlets)

        render :json => {:notification_text => @ad.sms_text}
    end
end
