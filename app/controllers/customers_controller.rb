class CustomersController < ApplicationController
    skip_before_filter  :verify_authenticity_token, :only => [:show, :get_mobile_number, :check_verification_code]

    def check_verification_code
        @customer = Customer.where(:uuid => params[:customer_uuid]).first
        if @customer.verification_code == (params[:verification_code])
            @customer.update_attributes(:is_verified => true, :name => params[:name])
            @verified = true
        else
            @customer.errors.add(:verification_code, "Enter correct verification code")
            @verified = false
        end
        render :json => {:verified => @verified}
    end

    def get_mobile_number
        @customer = Customer.where(:uuid => params[:customer_uuid]).first
        @existing_customer = Customer.where(:mobile_number => params[:mobile_number])
        if @existing_customer.exists?
            @customer = @existing_customer.first
            if @customer.is_verified == true
                @verified = true
            end
            @mobile_number = 'exist'
        else
            @customer.update_attributes(:mobile_number => params[:mobile_number])
            @sms_sent = @customer.misc_smss.create(:text => "Your verification code is #{@customer.verification_code} Thanks, Shoffr")
            @mobile_number = true
        end

        render :json => {:mobile_number => @mobile_number, :verified => @verified, :customer_uuid => @customer.uuid}
    end

    def show
        @customer = Customer.where(:mobile_number => params[:mobile_number]) unless params[:mobile_number].blank?
        if @customer.blank?
            @customer = Customer.where(:uuid => params[:customer_uuid]).first
        else
            @customer = @customer.first
        end
        respond_to do |format|
            format.json { render :json => {:mobile_number => @customer.mobile_number, :name => @customer.name}}
        end
    end

    def resend_verification_code
        @customer = Customer.where(:uuid => params[:customer_uuid]).first
        @sms_sent = @customer.misc_smss.create(:text => "Your verification code is #{@customer.verification_code} Thanks, Shoffr")
        render :json => {:success => true}
    end

    def location_from_ip
        result = Net::HTTP.get('freegeoip.net',"/json/#{request.remote_ip}")
        city = JSON.parse(result)['city']
        render :json => {:city => city}
    end
end
