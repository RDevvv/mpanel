class CustomersController < ApplicationController
    skip_before_filter  :verify_authenticity_token, :only => [:show, :get_mobile_number, :check_verification_code]
    before_filter :set_headers

    def set_headers
        response.headers['Access-Control-Allow-Origin'] = '*'
        response.headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
        response.headers['Access-Control-Request-Method'] = '*'
        response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
        response.headers['Accept-Encoding'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    end

  def check_verification_code
      @customer = Customer.where(:uuid => cookies[:customer_uuid]).first
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
      if Customer.all.map{|c| c.mobile_number}.uniq.include?(params[:mobile_number].to_i)
          @existing_customer = Customer.where(:mobile_number => params[:mobile_number]).first
          cookies[:customer_uuid] = {:value => @existing_customer.uuid, :expires => 1.year.from_now}
          if @existing_customer.is_verified == true
              cookies[:mobile_number] = {:value => "verified", :expires => 1.year.from_now}
              @verified = true
          else
              cookies[:mobile_number] = {:value => "false", :expires => 1.year.from_now}
          end
          @mobile_number = 'exist'
      else
          cookies[:mobile_number] = {:value => "false", :expires => 1.year.from_now}
          if @customer.update_attributes(:mobile_number => params[:mobile_number])
              @sms_sent = @customer.misc_smss.create(:text => "Your verification code is #{@customer.verification_code} Thanks, Shoffr")
              @mobile_number = true
          else
              @mobile_number = false
          end
      end
      respond_to do |format|
          format.json { render :json => {:mobile_number => @mobile_number, :verified => @verified}}
      end
  end

  def show
      @customer = Customer.where(:uuid => params[:customer_uuid]).first
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
