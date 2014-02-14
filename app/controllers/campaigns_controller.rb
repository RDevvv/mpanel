class CampaignsController < ApplicationController
    respond_to :html, :json

    # GET /campaigns
    # GET /campaigns.json
    def index
        @campaigns = Campaign.all

        respond_with @campaigns
    end

    # GET /campaigns/1
    # GET /campaigns/1.json
    def show
        @campaign = Campaign.find(params[:id])

        respond_with @campaign
    end

    # GET /campaigns/new
    # GET /campaigns/new.json
    def new
        @campaign = Campaign.new

        respond_with @campaign
    end

    # GET /campaigns/1/edit
    def edit
        @campaign = Campaign.find(params[:id])
    end

    # POST /campaigns
    # POST /campaigns.json
    def create
        @campaign = Campaign.new(params[:campaign])

        respond_with @campaign, :location => campaigns_path
    end

    # PUT /campaigns/1
    # PUT /campaigns/1.json
    def update
        @campaign = Campaign.find(params[:id])

        respond_with @campaign, :location => campaigns_path
    end

    # DELETE /campaigns/1
    # DELETE /campaigns/1.json
    def destroy
        @campaign = Campaign.find(params[:id])
        @campaign.destroy

        respond_with @campaign
    end

    def facebook_share
        if params[:short_url].nil?
            @ad_promocode_outlet = AdPromocodeOutlet.find(params[:ad_promocode_outlet_id])
        else
            @campaign = Campaign.where(:short_url => params[:short_url]).first
            @ad_promocode_outlet = @campaign.ad_promocode_outlet
        end
        @brand = @ad_promocode_outlet.ad.account_brand.brand
    end

    def campaign_landing
        campaign = Campaign.where(:short_url => params[:short_url])
        unless campaign.blank?
            campaign = campaign.first
            campaign.campaign_copies.create
            redirect_to campaign.pre_expiry_forward_url
        else
            campaign_copy = CampaignCopy.where(:short_url => params[:short_url]).first
            use_count = campaign_copy.use_count
            if use_count.blank?
                campaign_copy.update_attributes(:use_count => 0)
            end
            CampaignCopy.where(:short_url => params[:short_url]).first.update_attributes(:use_count=> campaign_copy.use_count+1)
            if campaign_copy.expires_at < Date.today-1
                redirect_to campaign_copy.campaign.pre_expiry_forward_url
            else
                redirect_to campaign_copy.campaign.post_expiry_forward_url
            end
        end
    end

    def generate_campaign_copy
        campaign_copy = Ad.find(params[:ad_id]).ad_promocode_outlets.where(:outlet_id => params[:outlet_id]).first.campaign.campaign_copies.create()

        respond_with do |format|
            format.json {render :json => {:short_url => campaign_copy.short_url}}
        end
    end
end
