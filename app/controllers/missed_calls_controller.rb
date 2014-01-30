class MissedCallsController < ApplicationController
    def get_missed_call
        unless MissedCall.exists?(:from => params[:From])
            customer = Customer.create(:mobile_number => params[:From], :uuid => Customer.generate_cookie)
            template = "Your contest entry is confirmed. We will call the lucky winner of Samsung Grand 2 on 14/02/14. Try http://gullak.co/xxxx for more Deals At Your Fingertips"
            campaign = Campaign.create(:marketer => "GM Marketer", :target => "customer", :source => "exotel", :medium => "SMS", :campaign_type => "auto trigger", :purpose => "acquisition", :campaign_template => template)
            @missed_call = MissedCall.create(:call_sid=>params["CallSid"],:from=>params[:From],:to=>params["To"], :campaign_id => campaign.id)
            CampaignCopy.create(:vendor_id => params["CallSid"], :customer_id => customer.id)
        end
        render :json => 'OK', :status => '200'
    end

    def get_sms_text
        campaign_copy = CampaignCopy.where(:vendor_id => params["CallSid"]).first
        template_1 = "Your contest entry is confirmed. We will call the lucky winner of Samsung Grand 2 on 14/02/14. Try gullak.co/"
        template_2 = " for more Deals At Your Fingertips"
        render :text => (template_1+campaign_copy.short_url+template_2), :status => '200'
    end
end
