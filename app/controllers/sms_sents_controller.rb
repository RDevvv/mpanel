class SmsSentsController < ApplicationController
    skip_before_filter  :verify_authenticity_token, :only => [:set_sms_data]
    layout "outlet_manager", :only => [:outletview_offers_log]

    def set_sms_data
        customer = Customer.where(:uuid => params[:customer_uuid]).first
        unless customer.mobile_number.nil? && customer.is_verified?
            if params[:misc_sms] == 'true'
                campaign_copy = Campaign.where(:medium => 'Email', :marketer => 'Merchant').first.campaign_copies.create(:customer_id => customer.id)
                customer.misc_smss.create(:text => "Check out http://shoffr.com/#{campaign_copy.short_url}. Shop with and offer via Shoffr")
            else
                AdLike.create(:ad_id => params[:ad_id], :outlet_id => params[:outlet_id], :customer_id => customer.id, :is_unlocked => true)
                ad = Ad.find(params[:ad_id])
                outlet = Outlet.find(params[:outlet_id])
                brand_name = ad.account_brand.brand.brand_name
                ad_promocode = ad.ad_promocodes.first
                ad_promocode.update_attributes(:usage => (ad_promocode.usage+1))
                ad_promocode_outlet = ad.ad_promocode_outlets.where(:outlet_id => params[:outlet_id]).first
                button_click = ButtonClick.where(:button_class => "ad_request", :customer_id => customer.id, :ad_id => ad.id).order(:id).last
                text = "<b>Offer:</b> #{ad.account_brand.brand.brand_name} #{ad.sms_text} <br /><b>Promocode:</b> #{ad_promocode.promocode} <br /><b>Address:</b><br /> #{outlet.shop_no}, #{outlet.address}<br /> #{outlet.area.area_name}<br /> #{outlet.area.city.city_name} #{outlet.area.pincode} Thanks, Shoffr"
                @sms_sent = SmsSent.create(:text => text, :customer_id => customer.id, :ad_promocode_outlet_id => ad_promocode_outlet.id, :ad_promocode_outlet_version_id => ad_promocode_outlet.versions.order(:id).last.id, :button_click_id => button_click.id)
            end
        end
    end

    def sms_share
        customer = Customer.where(:uuid => params[:customer_uuid]).first

        text = "Check out http://gullak.co/#{campaign_copy.short_url}. Shop with an offer via Shoffr"
        sms_sent = customer.sms_sents.create(:ad_promocode_outlet_id => 100000, :ad_promocode_outlet_version_id => 100000, :text => text)
        render :json => {:sms_sent => true, :text => text}
    end

    def outletview_offers_log
        @ad_promocode_outlet = AdPromocodeOutlet.where(:outlet_id => params[:id])
        @sms_sents = @ad_promocode_outlet.first.sms_sents
    end
end
