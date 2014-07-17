class CampaignsController < ApplicationController
  def campaign_landing
      campaign_copy = CampaignCopy.where(:short_url => params[:short_url]).first
      unless(campaign_copy).blank?
          campaign = campaign_copy.campaign
          campaign_copy.update_attributes(:use_count=> campaign_copy.use_count+1)
          Customer.where(:uuid => cookies['customer_uuid']).first.customer_campaign_copys.create(:campaign_copy_id => campaign_copy.id, :customer_ip => request.ip)
          if campaign.expires_in!= nil
              if(campaign.expires_at+campaign.expires_in.hours+330.minutes < Time.now)
                  redirect_to 'http://www.shoffr.com/'+campaign_copy.post_expiry_forward_url+"&short_url="+campaign_copy.short_url
              end
          elsif(campaign_copy.campaign.expires_at.blank?)||(campaign.expires_at > Date.today-1)
              redirect_to 'http://www.shoffr.com/'+campaign_copy.pre_expiry_forward_url+"&short_url="+campaign_copy.short_url
          else
              redirect_to 'http://www.shoffr.com/'+campaign_copy.post_expiry_forward_url+"&short_url="+campaign_copy.short_url
          end
      end
  end

  def generate_campaign_copy
      campaign_copy = Ad.find(params[:ad_id]).ad_promocode_outlets.where(:outlet_id => params[:outlet_id]).first.campaign.campaign_copies.create()

      respond_to do |format|
          format.json {render :json => {:short_url => campaign_copy.short_url}}
      end
  end

  def update_vendor_id
      if params[:marketer] == 'Merchant'
          Campaign.where(:medium => 'Email', :marketer => 'Merchant').first.campaign_copies.order(:id).last.update_attributes(:vendor_id => params[:post_id])
      else
          ad_promocode_outlet_ids = AdPromocodeOutlet.where(:ad_id => params[:ad_id], :outlet_id => params[:outlet_id]).map{|apo|apo.id}
          campaign_copy = Campaign.where(:ad_promocode_outlet_id => ad_promocode_outlet_ids).first.campaign_copies.order(:id).last.update_attributes(:vendor_id => params[:post_id])
      end
      render :json => {:success => true}
  end
end
