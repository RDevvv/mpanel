class CustomersController < ApplicationController
    skip_before_filter  :verify_authenticity_token, :only => [:show, :get_mobile_number, :check_verification_code]
    before_filter :set_headers

  def check_verification_code
      @customer = Customer.where(:uuid => params[:customer_uuid]).first
      if @customer.verification_code == (params[:verification_code])
          cookies[:mobile_number] = {:value => "verified", :expires => 1.year.from_now}
          @customer.update_attributes(:is_verified => true, :name => params[:name])
          @verified = true
      else
          @customer.errors.add(:verification_code, "Enter correct verification code")
          @verified = false
      end
      respond_to do |format|
          format.json { render :json => {:verified => @verified}}
      end
  end

  def get_mobile_number
      @customer = Customer.where(:uuid => params[:customer_uuid]).first
      @existing_customer = Customer.where(:mobile_number => params[:mobile_number])
      if @existing_customer.exists?
          @existing_customer = @existing_customer.first
          cookies[:customer_uuid] = {:value => @existing_customer.uuid, :expires => 1.year.from_now}
          if @existing_customer.is_verified == true
              cookies[:mobile_number] = {:value => "verified", :expires => 1.year.from_now}
              @verified = true
          else
              cookies[:mobile_number] = {:value => "false", :expires => 1.year.from_now}
          end
          @mobile_number = 'exist'
          @uuid = @existing_customer.uuid
      else
          cookies[:mobile_number] = {:value => "false", :expires => 1.year.from_now}
          if @customer.update_attributes(:mobile_number => params[:mobile_number])
              @sms_sent = @customer.misc_smss.create(:text => "Your verification code is #{@customer.verification_code} Thanks, Shoffr")
              @mobile_number = true
          else
              @mobile_number = false
          end
          @uuid = @customer.uuid
      end
      respond_to do |format|
          format.json { render :json => {:mobile_number => @mobile_number, :verified => @verified, :uuid => @uuid}}
      end
  end

  def show
      @customer = Customer.where(:mobile_number => params[:mobile_number]) unless params[:mobile_number].blank?
      if @customer.blank?
          @customer = Customer.where(:uuid => params[:customer_uuid]).first
      else
         a@customer = @customer.first
      end
      aespond_to do |format|
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
