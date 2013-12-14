class Merchant::AdsController <  Merchant::BaseController
	before_filter :load_account, :load_account_and_brand

	def index
		@ads = @account_brand.ads.active_ads		
    @expiry_ads = @account_brand.ads.expire_ads
	end
  
  def new
    @ad = @account_brand.ads.new
    @keywords = Keyword.all
  end

  def show
    @ad = @account_brand.ads.find(params[:id])
    @ad_groups = @ad.ad_groups
    @keywords = Keyword.all
    @ad_promocodes = @ad.ad_promocodes
  end

  def create
    @ad = @account_brand.ads.new(params[:ad])
    if @ad.save
      redirect_to new_merchant_account_account_brand_ad_ad_promocode_path(@current_account,@account_brand,@ad),:notice=>"Ad successfylly created"
    else
      @keywords = Keyword.all
      render :action=>"new"
    end
  end

  def edit
    @ad = @account_brand.ads.find(params[:id])
    @keywords = Keyword.all
  end

  def update
    @ad = @account_brand.ads.find(params[:id])
    if @ad.update_attributes(params[:ad])
      redirect_to  merchant_account_account_brand_ad_path(@current_account,@account_brand,@ad),:notice=>"Ad successfylly updated #{undo_link}"
    else
      @keywords = Keyword.all
      render :action=>"edit"
    end
  end
  
  def destroy
    @ad = @account_brand.ads.find(params[:id])
    @ad.destroy
    redirect_to merchant_account_account_brand_ads_path(@current_account,@account_brand),:notice=>"Ad successfylly Destroyed #{undo_link}"
  end

	protected
	def load_account_and_brand
		@account_brand = @current_account.account_brands.find(params[:account_brand_id])
	end
  
  private
  def undo_link
    view_context.link_to("undo", revert_version_path(@ad.versions.scoped.last), :method => :post)
  end
end