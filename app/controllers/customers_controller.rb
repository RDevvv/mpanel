class CustomersController < ApplicationController
    respond_to :html, :json

    def index
        @customers = Customer.all

        respond_with @customers
    end

    # GET /customers/1
    # GET /customers/1.json
    def show
        @customer = Customer.find(params[:id])

        respond_with @customer
    end

    def verify_mobile_number
        @customer = Customer.new

        respond_with @customer
    end

    def check_verification_code
        @customer = Customer.where(:uuid => cookies[:customer_uuid]).first
        puts @customer.verification_code
        puts params[:verification_code]
        # if @customer.is_verified == true
        #     @customer.errors.add(:already_verified, "This phone number is already verified")
        #     @verified = "already"
        if @customer.verification_code == (params[:verification_code])
            cookies[:mobile_number] = {:value => "verified", :expires => 1.year.from_now}
            @customer.update_attributes(:is_verified => true)
            @verified = true
        else
            @customer.errors.add(:verification_code, "Enter correct verification code")
            @verified = false
        end
        respond_with do |format|
            format.json { render :json => {:verified => @verified}}
        end
    end

    def get_mobile_number
        @customer = Customer.where(:uuid => params[:customer_uuid]).first
        @all_customers = Customer.all
        if @all_customers.map{|c| c.mobile_number}.uniq.include?(params[:mobile_number].to_i)
            @existing_customer = Customer.where(:mobile_number => params[:mobile_number]).first
            cookies[:customer_uuid] = {:value => @existing_customer.uuid, :expires => 1.year.from_now}
            if @existing_customer.is_verified == true
                cookies[:mobile_number] = {:value => "verified", :expires => 1.year.from_now}
            else
                cookies[:mobile_number] = {:value => "not_verified", :expires => 1.year.from_now}
            end
            @mobile_number = 'exist'
        else
            unless params[:mobile_number].empty?
                if @customer.update_attributes(:mobile_number => params[:mobile_number])
                    @sms_sent = @customer.sms_sents.create(:ad_promocode_outlet_id => 1, :ad_promocode_outlet_version_id => 1, :text => "Your verification code is #{@customer.verification_code} Thanks, GullakMaster.")
                    @sms_sent.send_message
                    @mobile_number = true
                else
                    @mobile_number = false
                end
            end
        end
        respond_with do |format|
            format.json { render :json => {:mobile_number => @mobile_number}}
        end
    end
end
