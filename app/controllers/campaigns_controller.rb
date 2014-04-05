class CampaignsController < ApplicationController
  # GET /campaigns
  # GET /campaigns.json
  def index
    @campaigns = Campaign.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @campaigns }
    end
  end

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show
    @campaign = Campaign.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @campaign }
    end
  end

  # GET /campaigns/new
  # GET /campaigns/new.json
  def new
    @campaign = Campaign.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @campaign }
    end
  end

  # GET /campaigns/1/edit
  def edit
    @campaign = Campaign.find(params[:id])
  end

  # POST /campaigns
  # POST /campaigns.json
  def create
    @campaign = Campaign.new(params[:campaign])

    respond_to do |format|
      if @campaign.save
        format.html { redirect_to @campaign, notice: 'Campaign was successfully created.' }
        format.json { render json: @campaign, status: :created, location: @campaign }
      else
        format.html { render action: "new" }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /campaigns/1
  # PUT /campaigns/1.json
  def update
    @campaign = Campaign.find(params[:id])

    respond_to do |format|
      if @campaign.update_attributes(params[:campaign])
        format.html { redirect_to @campaign, notice: 'Campaign was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
    @campaign = Campaign.find(params[:id])
    @campaign.destroy

    respond_to do |format|
      format.html { redirect_to campaigns_url }
      format.json { head :no_content }
    end
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
      campaign_copy = CampaignCopy.where(:short_url => params[:short_url]).first
      if(campaign_copy).blank?
          redirect_to :error_404
      else
          campaign = campaign_copy.campaign
          campaign_copy.update_attributes(:use_count=> campaign_copy.use_count+1)
          if(campaign.expires_at+campaign.expires_in.hours+330.minutes < Time.now)
              redirect_to campaign.post_expiry_forward_url+"?short_url="+campaign_copy.short_url
          elsif(campaign_copy.campaign.expires_at.blank?)||(campaign.expires_at > Date.today-1)
              redirect_to campaign.pre_expiry_forward_url+"?short_url="+campaign_copy.short_url
          else
              redirect_to campaign.post_expiry_forward_url+"?short_url="+campaign_copy.short_url
          end
      end
  end

  def generate_campaign_copy
      campaign_copy = Ad.find(params[:ad_id]).ad_promocode_outlets.where(:outlet_id => params[:outlet_id]).first.campaign.campaign_copies.create()

      respond_to do |format|
          format.json {render :json => {:short_url => campaign_copy.short_url}}
      end
  end

  def get_campaign_details
      customer = Customer.where(:uuid => params[:customer_uuid]).first
      if params[:button_class] == 'top_share'||params[:button_class] == 'new_top_share'
          campaign_copy = Campaign.where(:medium => 'Email', :marketer => 'Merchant').first.campaign_copies.create(:customer_id => customer.id)
          image_path = 'www.gullakmaster.com/assets/categories/Gullak_Master_Top.jpg'
          render :json => {:short_url => campaign_copy.short_url, :image_url => image_path}
      else
          ad = Ad.find(params[:ad_id])
          outlet = Outlet.find(params[:outlet_id])
          ad_promocode_outlet_ids = AdPromocodeOutlet.where(:ad_id => ad.id, :outlet_id => outlet.id).map{|apo|apo.id}
          campaign_copy = Campaign.where(:ad_promocode_outlet_id => ad_promocode_outlet_ids).first.campaign_copies.create(:customer_id => customer.id)
          category = ad.account_brand.brand.category
          image_path = "www.gullakmaster.com/assets/categories/"+category.name.gsub(" ","_")+"_big.jpg"
          render :json => {:brand_name =>ad.account_brand.brand.brand_name, :short_url => campaign_copy.short_url, :image_url => image_path, :category_name => category.name, :ad_title => ad.sms_text}
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
