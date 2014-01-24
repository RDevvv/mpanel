class Merchant::AdPromocodesController <  Merchant::BaseController
	before_filter :load_account, :load_account_brand, :load_ad

	def index
    @ad_groups = @ad.ad_groups
    @ad_promocodes = @ad.ad_promocodes
  end

  def new
    @ad_promocode = @ad.ad_promocodes.new
  end

  def create
    @ad_promocode = @ad.ad_promocodes.new(params[:ad_promocode])
    respond_to do |format|
      if @ad_promocode.save
        format.html { redirect_to merchant_account_account_brand_ad_ad_promocodes_path(@current_account,@account_brand,@ad),:notice=>"Promocode Succesfully added"}
      else
        format.html { render action: "new" }
      end
    end
  end

  # Only One promocode is available
  def add_single_code
    params[:ad_promocode][:cap] = params[:ad_promocode][:cap] || 1

    params[:ad_promocode][:outlet_ids] =params[:ad_promocode][:outlet_ids].reject {|x| x.blank?}
    params[:ad_promocode][:outlet_ids] = @account_brand.outlet_ids if params[:ad_promocode][:outlet_ids] &&  params[:ad_promocode][:outlet_ids].include?("All")
    @ad_promocode = @ad.ad_promocodes.new(params[:ad_promocode])
  
    respond_to do |format|
      @ad_group = @ad_promocode.add_ad_group(@ad,params[:ad_promocode][:set_name])
      @ad_promocode.ad_group = @ad_group
      if @ad_promocode.save
        format.html { redirect_to merchant_account_account_brand_ad_ad_group_path(@current_account,@account_brand,@ad,@ad_group),:notice=>"Promocode Succesfully added"}
      else
        format.html { render action: "new" }
      end  
    end
  end

  # Can Have multiple  promocode 
  def add_multiple_code
    ad_promocodes = [] 
    invalid_promocode =  false
    Array(params[:ad_promocode][:promocodes].split(",")).each do |promocode|
      if promocode.present?
        params[:ad_promocode][:outlet_ids] = params[:ad_promocode][:outlet_ids].reject {|x| x.blank?}
        params[:ad_promocode][:outlet_ids] = @account_brand.outlet_ids if params[:ad_promocode][:outlet_ids] &&  params[:ad_promocode][:outlet_ids].include?("All")
        params[:ad_promocode][:promocode] = promocode
        params[:ad_promocode][:cap] = 1
        ad_promocode = @ad.ad_promocodes.new(params[:ad_promocode])
        ad_promocodes <<  ad_promocode
        
        invalid_promocode = true unless ad_promocode.valid?
      end  
    end

    if invalid_promocode 
      @ad_promocode = @ad.ad_promocodes.new(params[:ad_promocode])
      render :action=>:new
    else
      @ad_group =  @ad.ad_groups.create!(:name=>params[:ad_promocode][:set_name],:is_multiple=>true)

      ad_promocodes.each do |promocode|
        promocode.ad_group = @ad_group
        promocode.save
      end
      redirect_to merchant_account_account_brand_ad_ad_group_path(@current_account,@account_brand,@ad,@ad_group),:notice=>"Promocode Succesfully added"
    end
    
  end

  def edit
    @ad_promocode = @ad.ad_promocodes.find(params[:id])
  end

  def update
    @ad_promocode = @ad.ad_promocodes.find(params[:id])
    if @ad_promocode.update_attributes(params[:ad_promocode])
      redirect_to  merchant_account_account_brand_ad_ad_promocode_path(@current_account,@account_brand,@ad),:notice=>"Promocode successfylly updated"
    else
      render :action=>"edit"
    end
  end

  def show
    @ad_promocode = @ad.ad_promocodes.find(params[:id])
  end

  def destroy
    @ad_promocode = @ad.ad_promocodes.find(params[:id])
    @ad_group = @ad_promocode.ad_group
    @ad_promocode.destroy
    redirect_to merchant_account_account_brand_ad_ad_group_path(@current_account,@account_brand,@ad,@ad_group)
  end

  protected
  def load_account_brand
    @account_brand = @current_account.account_brands.find(params[:account_brand_id])
  end

  def load_ad
    @ad = @account_brand.ads.find(params[:ad_id])
  end

end