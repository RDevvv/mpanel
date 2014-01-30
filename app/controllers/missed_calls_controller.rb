class MissedCallsController < ApplicationController
    def get_missed_call
        unless MissedCall.exists?(:from => params[:CallFrom])
            customer = Customer.create(:mobile_number => params[:CallFrom], :uuid => Customer.generate_cookie)
            template = "Your contest entry is confirmed. We will call the lucky winner of Samsung Grand 2 on 14/02/14. Try http://gullak.co/xxxx for more Deals At Your Fingertips"
            campaign = Campaign.where(:marketer => "GM Marketer", :target => "customer", :source => "exotel", :medium => "SMS", :type => "auto trigger", :purpose => "acquisition", :Campaign_template => template)
            @missed_call = MissedCall.create(:call_sid=>params["CallSid"],:from=>params[:CallFrom],:to=>params["CallTo"], :campaign_id => campaign.id)
            CampaignCopy.create(:vendor_id => params["CallSid"], :customer_id => customer.id)
        end
        render :json => 'OK', :status => '200'
    end

    def get_sms_text
        campaign_copy = CampaignCopy.where(:vendor_id => params["CallSid"]).first
        final_text = campaign_copy.campaign.campaign_template
            template_1 = "Your contest entry is confirmed. We will call the lucky winner of Samsung Grand 2 on 14/02/14. Try gullak.co/"
            template_2 = " for more Deals At Your Fingertips"
        render :text => (template_1+campaign_copy.short_url+template_2), :status => '200'
    end

    def self.add_exotel_campaign()
            Campaign.create(:marketer => "GM Marketer", :target => "customer", :source => "exotel", :medium => "SMS", :type => "auto trigger", :purpose => "acquisition", :campaign_template => "Your contest entry is confirmed. We will call the lucky winner of Samsung Grand 2 on 14/02/14. Try gullak.co/xxxx for more Deals At Your Fingertips")
    end
end
