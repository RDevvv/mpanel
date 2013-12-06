class Merchant::AdPromocodesController <  Merchant::BaseController
	before_filter :load_account, :load_account_brand, :load_ad

	def index
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
    @ad_promocode = @ad.ad_promocodes.new(params[:ad_promocode])
    respond_to do |format|
      if @ad_promocode.save
        format.html { redirect_to merchant_account_account_brand_ad_ad_promocodes_path(@current_account,@account_brand,@ad),:notice=>"Promocode Succesfully added"}
      else
        format.html { render action: "new" }
      end
    end
  end

  # Can Have multiple  promocode 
  def add_multiple_code
    binding.pry
    Array(params[:ad_promocode][:promocode].split(",")).each do |promocode|
      params[:ad_promocode][:promocode] = promocode
      ad_promocode = @ad.ad_promocodes.new(params[:ad_promocode])
      ad_promocode.save               
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
    @ad_promocode.destroy
    redirect_to merchant_account_account_brand_ad_ad_promocodes_path(@current_account,@account_brand,@ad)
  end

  protected
  

  def load_account_brand
    @account_brand = @current_account.account_brands.find(params[:account_brand_id])
  end

  def load_ad
    @ad = @account_brand.ads.find(params[:ad_id])
  end

end