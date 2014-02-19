class SmsSentsController < ApplicationController
    skip_before_filter  :verify_authenticity_token, :only => [:set_sms_data]

    # GET /sms_sents
    # GET /sms_sents.json
    def index
        @sms_sents = SmsSent.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @sms_sents }
        end
    end

    # GET /sms_sents/1
    # GET /sms_sents/1.json
    def show
        @sms_sent = SmsSent.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @sms_sent }
        end
    end

    def set_sms_data
        customer = Customer.where(:uuid => params[:customer_uuid]).first
        unless customer.mobile_number.nil?
            if customer.is_verified?
                ad = Ad.find(params[:ad_id])
                outlet = Outlet.find(params[:outlet_id])
                ad_promocode = ad.ad_promocodes.first
                ad_promocode.update_attributes(:usage => (ad_promocode.usage+1))
                ad_promocode_outlet = ad.ad_promocode_outlets.where(:outlet_id => params[:outlet_id]).first
                button_click = ButtonClick.where(:button_class => "ad_request", :customer_id => customer.id, :ad_id => ad.id).order(:id).last
                text = "Offer: #{ad.account_brand.brand.brand_name} #{ad.sms_text} Promocode: #{ad_promocode.promocode} Address: #{outlet.address}, #{outlet.area.area_name}, #{outlet.area.city.city_name} #{outlet.area.pincode} Thanks, GullakMaster"
                @sms_sent = SmsSent.create(:text => text, :customer_id => customer.id, :ad_promocode_outlet_id => ad_promocode_outlet.id, :ad_promocode_outlet_version_id => ad_promocode_outlet.versions.order(:id).last.id, :button_click_id => button_click.id)

                render :json => {:mobile_number_presence => true, :text => text}
            else
                render :json => {:mobile_number_presence => false, :exist_but_not_verified => true, :customer_id => customer.id}
            end
        else
            render :json => {:mobile_number_presence => false, :customer_id => customer.id}
        end
    end

    def sms_share
        customer = Customer.where(:uuid => params[:customer_uuid]).first
        text = "GullakMaster has awesome Deals At Your Fingertips! http://gullak.co/sms Check it out."
        sms_sent = customer.sms_sents.create(:ad_promocode_outlet_id => 100000, :ad_promocode_outlet_version_id => 100000, :text => text)
        sms_sent.send_message
        render :json => {:sms_sent => true, :text => text}
    end

end
